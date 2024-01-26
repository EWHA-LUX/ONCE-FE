import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_front/style.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  Widget _gradationBody(context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/2,
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
        ) ,
        Positioned(
          top: 150,
          left: 160,
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
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Stack(
        children: [
          _gradationBody(context),
          Padding(
            padding: const EdgeInsets.only(top: 300.0, left: 50.0),
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
                    style:TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(top: 70.0, left: 25.0),
                  child: SizedBox(
                    width: 270,
                    height: 35,
                    child: TextField(
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
                        fillColor: Color(0xffeaeaea),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25, top: 120),
                  child: Text(
                    '비밀번호',
                    style:TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(top: 155.0, left: 25.0),
                  child: SizedBox(
                    width: 270,
                    height: 35,
                    child: TextField(
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
                        fillColor: Color(0xffeaeaea),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 700.0, left: 20.0),
                  child: GestureDetector(
                    child: Container(
                      height: 50,
                      width: 320,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(20)
                        ),
                        border: Border.all(
                          color: ColorStyles.mainBlue,
                        ),
                      ),
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ColorStyles.mainBlue,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("/");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 800.0, left: 20.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: const Text(
                          '회원가입',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: ColorStyles.grey,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("/"); // 차후 변경
                        },
                      ),
                      GestureDetector(
                        child: const Text(
                          '아이디 비밀번호 찾기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: ColorStyles.grey,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("/"); // 차후 변경
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