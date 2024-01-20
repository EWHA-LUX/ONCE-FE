import 'package:flutter/material.dart';
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

  var _selectedIndex = 0;
  late AnimationController _lineAnimationController;

  final List<bool> _isFlippedList = List.generate(
      cardBannerList.length,
          (index) => false,
  );

  @override
  void initState() {
    super.initState();
    _lineAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 60.0),
            child: Text(
              '모든 카드 혜택을 한눈에',
              style: TextStyles.TitleKorean,
            ),
          ),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 28.0, top: 1),
                child: Text(
                  '루스님을 위해 맞춤화된 카드 혜택 정보를 알아보세요.',
                  style: TextStyles.SemiTitle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 45),
          Container(
            // 카드 위젯 margin 및 height 정의
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 350,
            // 페이지에 따라 index 변경
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                  print(_lineAnimationController.status);
                  _lineAnimationController.forward(from:0.0);
                });
              },
              // 카드 좌우 오버랩 설정
              controller: PageController(viewportFraction: 0.6),
              itemCount: cardBannerList.length,
              itemBuilder: (context, index) {
                var banner = cardBannerList[index];
                var isFlipped = _isFlippedList[index];
                // 카드 선택 여부에 따라 크기 변경
                var _scale = _selectedIndex == index ? 1.0 : 0.7;
                double _angle = 0;

                // 카드 스와이프 애니메이션 구현
                return TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 350),
                    tween: Tween(begin: _scale, end: _scale),
                    curve: Curves.ease,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          _isFlippedList[index] = !_isFlippedList[index];
                          _angle = (_angle + 3.14) % (2 * 3.14);
                        });
                      },
                      child: AnimatedContainer(
                        //tween: Tween<double>(begin: 0, end:_angle),
                        duration: const Duration(milliseconds: 500),
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(isFlipped ? 3.14 : 0),
                        child: CardItem(
                          cardBanner: banner,
                          isFlipped: _isFlippedList[index],
                        ),
                      ),
                    ),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // indicator 개수 동적으로 생성
              ...List.generate(cardBannerList.length, (index) =>
                  Indicator(isActive: _selectedIndex == index ? true : false),
              )
            ],
          ),
          const SizedBox(height: 20),
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

