import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:get/get.dart';
import 'package:once_front/style.dart';
import 'package:flutter_svg/svg.dart';

class Signup2 extends StatefulWidget {
  const Signup2({Key? key}) : super(key: key);

  @override
  _Signup2State createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  int passwordsMatch = 0;

  void checkPasswordMatch() {
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    setState(() {
      if (password.isEmpty || confirmPassword.isEmpty) {
        passwordsMatch = 0;
      } else if (password == confirmPassword){
        passwordsMatch = 1;
      } else {
        passwordsMatch = 2;
      }
    });
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Positioned(
                      top: 25,
                      left: 25,
                      child: GestureDetector(
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("/signup/1");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '아이디 / 비밀번호 설정',
                            style: TextStyles.TitleKorean,
                          ),
                          Positioned(
                            top: 25,
                            right: 25,
                            child: Container(
                              // 상단 step 바 구현
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    const Text(
                      '보안을 위해 안전한 아이디와 비밀번호를 입력해주세요.',
                      style: TextStyles.SemiTitle,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 172.5 ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '아이디',
                      textAlign: TextAlign.left,
                      style:TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    SizedBox(
                      width: 345,
                      height: 40,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          hintText: 'onceonce1234',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(top: 2.0, left: 14.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 172.5 ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '비밀번호',
                      textAlign: TextAlign.left,
                      style:TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    SizedBox(
                      width: 345,
                      height: 40,
                      child: TextField(
                        controller: passwordController,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: InputDecoration(
                          hintText: '여섯 자리 숫자 입력',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(top: 2.0, left: 14.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 172.5 ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '비밀번호 확인',
                      textAlign: TextAlign.left,
                      style:TextStyle(
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

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(top: 2.0, left: 14.0),
                          suffixIcon: suffixIcons,
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    if (passwordsMatch == 1)
                      const Padding(
                        padding: EdgeInsets.only(left: 9),
                        child: Text(
                          '비밀번호가 일치합니다.',
                          textAlign: TextAlign.left,
                          style:TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    if (passwordsMatch == 2)
                      const Padding(
                        padding: EdgeInsets.only(left: 9),
                        child: Text(
                          '비밀번호가 일치하지 않습니다.',
                          textAlign: TextAlign.left,
                          style:TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 270,
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 177.5 ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 45,
                        width: 355,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.topLeft,
                            colors: [
                              Color(0xff5B87FD),
                              Color(0xff978EFD),
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(20)
                          ),
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
                        Navigator.of(context).pushNamed("/signup/3");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}