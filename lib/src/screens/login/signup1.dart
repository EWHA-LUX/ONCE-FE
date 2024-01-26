import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:get/get.dart';
import 'package:once_front/style.dart';

class Signup1 extends StatelessWidget {
  const Signup1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
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
              Positioned(
                top: 25,
                right: 25,
                child: Container(
                  // 상단 step 바 구현
                ),
              ),
            ],
          ),
          const Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '회원가입',
                    style: TextStyles.TitleKorean,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    '서비스 이용을 위한 개인정보를 입력해 주세요.',
                    style: TextStyles.SemiTitle,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          const Text(
            '이름',
            style:TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            width: 270,
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
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          const Text(
            '닉네임',
            style:TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            width: 270,
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
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          const Text(
            '휴대폰 번호',
            style:TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            width: 270,
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
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          const Text(
            '(선택) 생년월일',
            style:TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            width: 270,
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
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          GestureDetector(
            child: Container(
              height: 50,
              width: 310,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color(0xff4472fc),
                    Color(0xff8877d5),
                  ],
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(20)
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 130.0, top: 10),
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
              Navigator.of(context).pushNamed("/");
            },
          ),
        ],
      ),
    );
  }
}