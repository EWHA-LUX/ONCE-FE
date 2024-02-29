import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/style.dart';
import 'package:once_front/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Signup2 extends StatefulWidget {
  final String username;
  final String nickname;
  final String userPhoneNum;
  final String birthday;

  Signup2({
    Key? key,
    required this.username,
    required this.nickname,
    required this.userPhoneNum,
    required this.birthday,
  }) : super(key: key);

  @override
  _Signup2State createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  final String BASE_URL = Constants.baseUrl;
  TextEditingController loginIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  int passwordsMatch = 0;

  void _signup(BuildContext context, String username, String loginId,
      String nickname, String password, String userPhoneNum,
      String birthday) async {
      final String apiUrl = '${BASE_URL}/user/signup';

    try {
      var response = await Dio().post(
        apiUrl,
        data: {
          "username": username,
          "loginId": loginId,
          "nickname": nickname,
          "password": password,
          "userPhoneNum": userPhoneNum,
          "birthday": birthday
        },
      );
      Map<String, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        String accessToken = responseData['result']['accessToken'];
        String refreshToken = responseData['result']['refreshToken'];

        // 토큰 local storage 저장
        final storage = new FlutterSecureStorage();
        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'refreshToken', value: refreshToken);

        Navigator.of(context).pushNamed("/signup/3");
      } else {
        showDialog( // ** 차후 수정 필요 **
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("회원가입 실패"),
              content: Text("회원가입 정보가 잘못되었습니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("확인"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) { // ** 차후 수정 필요 **
      print(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("오류 발생"),
            content: Text("서버와 통신 중 오류가 발생했습니다."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

  void checkPasswordMatch() {
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    setState(() {
      if (password.isEmpty || confirmPassword.isEmpty) {
        passwordsMatch = 0;
      } else if (password == confirmPassword) {
        passwordsMatch = 1;
      } else {
        passwordsMatch = 2;
      }
    });
  }

  Widget StepIcon(String num, bool isCurrentStep) {
    return Container(
      width: 21,
      height: 21,
      decoration: isCurrentStep
          ? const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xff4472fc),
            Color(0xff8877d5),
          ],
        ),
      )
          : const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffd5d5d5),
      ),
      child: Center(
        child: Text(
          num,
          style: TextStyle(
            color: isCurrentStep ? Colors.white : const Color(0xff757575),
            fontFamily: 'Pretendard',
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget StepWidget() {
    return Row(
      children: [
        StepIcon('1', true),
        Container(
          height: 2,
          width: 12,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xff4472fc),
                Color(0xff8877d5),
              ],
            ),
          ),
        ),
        StepIcon('2', true),
        Container(
          height: 2,
          width: 12,
          color: Color(0xffd5d5d5),
        ),
        StepIcon('3', false),
        Container(
          height: 2,
          width: 12,
          color: Color(0xffd5d5d5),
        ),
        StepIcon('4', false),
      ],
    );
  }

  // 상단 뒤로가기 버튼 + 스텝 표시
  Widget _stepArea(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pushNamed("/signup/1");
          },
        ),
        StepWidget()
      ],
    );
  }

  Widget _infoArea() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 10.0, bottom: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '아이디/비밀번호 설정',
            style: TextStyles.TitleKorean,
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            '보안을 위해 안전한 아이디와 비밀번호를 입력해 주세요.',
            style: TextStyles.SemiTitle,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcons;
    if (passwordsMatch == 1) {
      suffixIcons = Container(
        margin: EdgeInsets.all(8),
        child: SvgPicture.asset(
          'assets/images/icons/signup_check_icon.svg',
          width: 15,
        ),
      );
    } else if (passwordsMatch == 2) {
      suffixIcons = Container(
        margin: EdgeInsets.all(8),
        child: SvgPicture.asset(
          'assets/images/icons/signup_uncheck_icon.svg',
          width: 15,
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 25.0, vertical: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _stepArea(context),
                  _infoArea(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '아이디',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: loginIdController,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                            decoration: InputDecoration(
                              hintText: 'onceonce1234',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                              EdgeInsets.fromLTRB(12, 12, 12, 12),
                              isCollapsed: true,
                              suffixIcon: Container(
                                margin: EdgeInsets.all(8),
                                child: SvgPicture.asset(
                                  'assets/images/icons/signup_check_icon.svg',
                                  // SVG 파일의 경로
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 9),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            '사용 가능한 아이디입니다.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        const Text(
                          '비밀번호',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            decoration: const InputDecoration(
                              hintText: '여섯 자리 숫자 입력',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                              EdgeInsets.fromLTRB(12, 12, 12, 12),
                              isCollapsed: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        const Text(
                          '비밀번호 확인',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        SizedBox(
                          width: 345,
                          height: 40,
                          child: TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            onChanged: (value) {
                              checkPasswordMatch();
                            },
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                              EdgeInsets.fromLTRB(12, 12, 12, 12),
                              isCollapsed: true,
                              suffixIcon: suffixIcons,
                            ),
                          ),
                        ),
                        const SizedBox(height: 9),
                        if (passwordsMatch == 1)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              '비밀번호가 일치합니다.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        if (passwordsMatch == 2)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              '비밀번호가 일치하지 않습니다.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          child: Container(
                            height: 45,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.topLeft,
                                colors: [
                                  Color(0xff5B87FD),
                                  Color(0xff978EFD),
                                ],
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                '다음',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            _signup(
                              context,
                              widget.username,
                              loginIdController.text,
                              widget.nickname,
                              passwordController.text,
                              widget.userPhoneNum,
                              widget.birthday,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
