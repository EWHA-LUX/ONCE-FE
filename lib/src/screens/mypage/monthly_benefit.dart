import 'dart:math';

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
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            // 상단 그라데이션 배경
            height: 560,
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
          // 뒤로가기 버튼
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
              // 월별 혜택 조회 타이틀
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
              // 알림 이동하기
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
          // 월별 혜택 조회 세미 타이틀
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
          // 혜택 조회 상단 화이트 박스
            Stack(
              children: [
                Positioned(
                  top: 160,
                  left: MediaQuery.of(context).size.width / 2 - 190,
                  child: Container(
                    width: 380,
                    height: 230,
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
                          ),
                        ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        '$month월의 혜택',
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 18,
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
                          // 목표 수정하기 버튼 - 추가
                          Padding(
                            padding: EdgeInsets.only(right: 2.0),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 60.0, top: 20.0),
                            child: Container(
                              child: Circular_arc(
                                key: UniqueKey(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 110.0, top: 40.0),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/3d_icons/coins_3d_icon.svg',
                                  width: 80,
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  '126,000원 할인',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 430),
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
      ),
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
            children: [
            ],
          ),
        ],
      ),
    );
  }
}

class Circular_arc extends StatefulWidget {
  const Circular_arc({
    required Key key,
  }) : super(key: key);

  @override
  _Circular_arcState createState() => _Circular_arcState();
}

class _Circular_arcState extends State<Circular_arc> with SingleTickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);

    final curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeInOutCubic);

    animation = Tween<double>(begin: 0.0, end: 2.3).animate(curvedAnimation)..addListener(() {
      setState(() {

      });
    });
    animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      colors: [
        Color(0xff4472fc),
        Color(0xff8877d5),
      ],
    );

    return Stack(
      children: [
        CustomPaint(
          size: const Size(210, 210),
          painter: ProgressArc(0.0, gradient, true),
        ),
        CustomPaint(
          size: const Size(210, 210),
          painter: ProgressArc(animation.value, gradient, false),
        ),
      ],
    );
  }
}

class ProgressArc extends CustomPainter {
  bool isBackGround;
  double arc;
  Gradient progressColor;

  ProgressArc(this.arc, this.progressColor, this.isBackGround);

  @override
  void paint(Canvas canvas, Size size) {
    const rect = Rect.fromLTRB(0, 0, 210, 210);
    const startAngle = -pi;
    final sweepAngle = arc ?? pi;
    const userCenter = false;
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    if(!isBackGround) {
      paint.shader = progressColor.createShader(rect);
    }
    canvas.drawArc(rect, startAngle, sweepAngle, userCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
