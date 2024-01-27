import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:get/get.dart';
import 'package:once_front/style.dart';

class Signup2 extends StatelessWidget {
  const Signup2({super.key});

  @override
  Widget build(BuildContext context) {
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
                          Get.back();
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
                child: const Column(
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
                        style: TextStyle(
                          fontSize: 13,
                        ),
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
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '비밀번호 확인',
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