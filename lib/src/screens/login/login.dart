import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_front/constants.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:dio/dio.dart';


class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController loginIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String BASE_URL = Constants.baseUrl;
  void _login(BuildContext context, String loginId, String password) async {
    final String apiUrl = '${BASE_URL}/user/login';

    try {
      var response = await Dio().post(
        apiUrl,
        data: {"loginId": loginId, "password": password},
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

        Navigator.of(context).pushNamed("/");
      } else {
        showDialog( // ** 차후 수정 필요 **
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("로그인 실패"),
              content: Text("아이디 또는 비밀번호가 잘못되었습니다."),
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

  Widget _gradationBody(context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xff5B87FD),
                Color(0xff978EFD),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(300.0, 130.0),
              bottomRight: Radius.elliptical(300.0, 130.0),
            ),
          ),
        ),
        Positioned(
          top: 150,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/once_logo/once_logo_white.svg',
                width: 100,
              ),
              const SizedBox(height: 2),
              const Text(
                'ONCE',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Stack(
        children: [
          _gradationBody(context),
          Padding(
            padding: EdgeInsets.only(
                top: 300.0, left: MediaQuery.of(context).size.width / 2 - 160),
            child: Stack(
              children: [
                Container(
                  width: 320,
                  height: 235,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25, top: 35),
                  child: Text(
                    '아이디',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 68.0, left: 25.0),
                  child: SizedBox(
                    width: 270,
                    height: 40,
                    child: TextField(
                      controller: loginIdController,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        filled: true,
                        fillColor: Color(0xffeeeeee),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25, top: 120),
                  child: Text(
                    '비밀번호',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 153.0, left: 25.0),
                  child: SizedBox(
                    width: 270,
                    height: 40,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        filled: true,
                        fillColor: Color(0xffeeeeee),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7.0, top: 260),
                  child: InkWell(
                    splashColor: Color(0xff599cff).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      height: 50,
                      width: 310,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: const Color(0xff599cff),
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '로그인',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff599cff),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      _login(context, loginIdController.text, passwordController.text);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 325.0, left: 17.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: const Text(
                          '회원가입',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff858585),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("/signup/1");
                        },
                      ),
                      const SizedBox(width: 122),
                      GestureDetector(
                        child: const Text(
                          '아이디/비밀번호 찾기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff858585),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("/"); // ** 변경 필요 **
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
