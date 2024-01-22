import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:get/get.dart';
import 'package:once_front/style.dart';
import 'package:flutter_svg/svg.dart';

class MonthlyBenefit extends StatelessWidget {
  const MonthlyBenefit({super.key});

  final int month = 8;
  final String remainAmount = "5,600";


  Widget _gradationBody(context) {
    return Stack(
      children: [
        Container(
          // 상단 그라데이션 배경
          height: 550,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xff4472fc),
                Color(0xff8877d5),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(300.0, 130.0),
              bottomRight: Radius.elliptical(300.0, 130.0),
            )
          ),
        ),
        Positioned(
          top: 25,
          left: 25,
          child: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.back();
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 28.0, top: 70),
              child: Text(
                '월별 혜택 조회',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                  color: Colors.white,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 28.0, top: 70),
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/images/icons/alarm_icon.svg',
                  width: 28,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/notification");
                },
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 28.0, top: 110),
          child: Text(
            '이번 달 원스로 받은 모든 혜택을 알려드려요.',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Color(0xE8DEDEDE),
            )
          ),
        ),
        Positioned(
          top: 160,
          left: MediaQuery.of(context).size.width / 2 - 190,
          child: Container(
            width: 380,
            height: 220,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.3,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '$month월의 혜택',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2.0),
                        child: Text(
                          '이번 달 목표까지 5,600원 부족해요.',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff767676)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 2.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 28.0, top: 410),
          child: Text(
              '혜택 자세히 보기',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.white,
              ),
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
      body: Column(
        children: [
          _gradationBody(context),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
