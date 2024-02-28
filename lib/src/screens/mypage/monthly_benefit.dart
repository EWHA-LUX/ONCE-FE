import 'dart:math';

import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/svg.dart';

class MonthlyBenefit extends StatelessWidget {
  const MonthlyBenefit({super.key});

  final int month = 8;
  final String remainAmount = "5,600";

  Widget _gradationBody(context) {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            // 상단 그라데이션 배경
            height: 560,
            width: MediaQuery
                .of(context)
                .size
                .width,
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
                )),
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
                child: Text('월별 혜택 조회',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                      color: Colors.white,
                    )),
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
            child: Text('이번 달 원스로 받은 모든 혜택을 알려드려요.',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xE8DEDEDE),
                )),
          ),
          // 혜택 조회 상단 화이트 박스
          Positioned(
            top: 160,
            left: MediaQuery
                .of(context)
                .size
                .width / 2 - 170,
            child: Container(
              width: 340,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(
                      '$month월의 혜택',
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '이번 달 목표까지 5,600원 부족해요.',
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Color(0xff767676)),
                          ),

                          // 목표 수정하기 버튼
                          GestureDetector(
                            child: Container(
                              width: 110,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Color(0xffF2F2F2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      '목표 수정하기',
                                      style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff828282)),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 10,
                                      color: Color(0xff828282),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .width / 2 - 130,
                            top: 20.0),
                        child: Container(
                          child: Circular_arc(
                            key: UniqueKey(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .width / 2 - 75,
                            top: 40.0),
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
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 430),
            child: Text(
              '혜택 자세히 보기',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _benefitCategory(context, String iconPath, String category,
      String benefitAmout, String benefit, double percent) {
    return Center(
      child: Container(
        width: 340,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xffefefef),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    width: 30,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 카테고리
                          Text(
                            category,
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          // 해당 카테고리에서 받은 혜택
                          Text(
                            benefitAmout,
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // 카테고리별 할인 정보
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '할인 : $benefit',
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff737373),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // 카테고리별 실적 그래프
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: LinearPercentIndicator(
                        width: 220,
                        animation: true,
                        lineHeight: 6,
                        animationDuration: 900,
                        percent: percent,
                        barRadius: Radius.circular(20),
                        linearGradient: const LinearGradient(
                          colors: [
                            Color(0xff5B87FD),
                            Color(0xff978EFD),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                        ),
                        backgroundColor: const Color(0xfff2f2f2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: EmptyAppBar(),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            _gradationBody(context),
            Padding(
              padding: const EdgeInsets.only(top: 460.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    _benefitCategory(
                        context,
                        "assets/images/3d_icons/pizza_3d_icon.svg",
                        "음식점",
                        "55,600원",
                        "120,000원",
                        0.6),
                    const SizedBox(height: 13),
                    _benefitCategory(
                        context,
                        "assets/images/3d_icons/convenience_store_3d_icon.svg",
                        "편의점",
                        "13,600원",
                        "10,000원",
                        0.4),
                    const SizedBox(height: 13),
                    _benefitCategory(
                        context,
                        "assets/images/3d_icons/game_3d_icon.svg",
                        "영화관",
                        "12,300원",
                        "13,000원",
                        0.2),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class Circular_arc extends StatefulWidget {
  const Circular_arc({
    required Key key,
  }) : super(key: key);

  @override
  _Circular_arcState createState() => _Circular_arcState();
}

// 월별 혜택 조회 progress bar 애니메이션
class _Circular_arcState extends State<Circular_arc>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    final curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutCubic);

    animation = Tween<double>(begin: 0.0, end: 2.3).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      colors: [
        Color(0xff5B87FD),
        Color(0xff978EFD),
      ],
    );

    LinearGradient whitegradient = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      colors: [
        Color(0xfff2f2f2),
        Color(0xfff2f2f2),
      ],
    );

    return Stack(
      children: [
        CustomPaint(
          size: const Size(130, 130),
          painter: ProgressArc(3.14, whitegradient, false),
        ),
        CustomPaint(
          size: const Size(130, 130),
          painter: ProgressArc(animation.value, gradient, false),
        ),
      ],
    );
  }
}

// 월별 혜택 조회 arc progress bar 그리기
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

    if (!isBackGround) {
      paint.shader = progressColor.createShader(rect);
    }
    canvas.drawArc(rect, startAngle, sweepAngle, userCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
