import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:once_front/src/screens/mywallet/cardbanner.dart';
import 'package:once_front/style.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'card_item.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> with SingleTickerProviderStateMixin {

  var _selectedIndex = 0; // 현재 선택된 카드

  // 카드 뒤집기
  double angle = 0;
  void _flip(int index) {
    setState(() {
      _isFlippedList[index] = !_isFlippedList[index];
      //angle = (angle + pi) % (2 * pi);
    });
  }

  // 카드 뒤집기 여부 확인 리스트
  final List<bool> _isFlippedList = List.generate(
    cardBannerList.length,
        (index) => false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 뒤로가기 버튼
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 30.0),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 상단 타이틀
                  const Padding(
                    padding: EdgeInsets.only(left: 28.0, top: 20.0),
                    child: Text(
                      '모든 카드 혜택을 한눈에',
                      style: TextStyles.TitleKorean,
                    ),
                  ),
                  // 알림 아이콘
                  Padding(
                    padding: EdgeInsets.only(right: 27.0, top: 20.0),
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        'assets/images/icons/alarm_icon.svg',
                        width: 28,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed("/notification");
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          // 상단 세미 타이틀
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 1),
            child: Text(
              '루스님을 위해 맞춤화된 카드 혜택 정보를 알아보세요.',
              style: TextStyles.SemiTitle,
            ),
          ),
          const SizedBox(height: 34),
          // 보유 카드 위젯
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 350,
            // 페이지에 따라 index 변경
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              // 좌우 오버랩 카드 설정
              controller: PageController(viewportFraction: 0.6),
              itemCount: cardBannerList.length,
              itemBuilder: (context, index) {
                var banner = cardBannerList[index];
                var isFlipped = _isFlippedList[index];
                // 카드 선택 여부에 따라 크기 변경
                var _scale = _selectedIndex == index ? 1.0 : 0.7;
                double _angle = 0;

                // 카드 스와이프 애니메이션 구현
                return GestureDetector(
                  onTap: () => _flip(index),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: _isFlippedList[index] ? pi : 0),
                    duration: Duration(seconds: 1),
                    builder: (BuildContext context, double val, __) {
                      return Transform.scale(
                        scale: _scale,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(val),
                          child: CardItem(
                            cardBanner: banner,
                            isFlipped: _isFlippedList[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          // 카드 인디케이터
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(cardBannerList.length, (index) =>
                  Indicator(isActive: _selectedIndex == index ? true : false),
              )
            ],
          ),
          const SizedBox(height: 16),
          // 하단 화이트 박스 생성
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 23.0),
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                // 카드 이름
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        cardBannerList[_selectedIndex].cardName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 남은 실적 정보
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "이번 달 실적까지 ${cardBannerList[_selectedIndex].remainAmount}원 남았어요.",
                        style: const TextStyle(
                          color: Color(0xFF767676),
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 실적 그래프
                    Container(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          LinearPercentIndicator(
                            width: 300,
                            animation: true,
                            lineHeight: 6,
                            animationDuration: 900,
                            percent: cardBannerList[_selectedIndex].performance,
                            barRadius: Radius.circular(20),
                            //progressColor: Colors.black,
                            linearGradient: const LinearGradient(
                              colors: [
                                Color(0xff9982da),
                                Color(0xff8396dc),
                              ],
                              stops: [0.0, 1.0],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            backgroundColor: Color(0xffd2d2d2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// indicator원으로 현재 선택된 페이지 표시
class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 18.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: isActive ? Color(0xFF525252): Color(0xFFBDBDBD),
      ),
    );
  }
}