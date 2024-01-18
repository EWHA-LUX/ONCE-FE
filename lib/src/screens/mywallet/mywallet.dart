import 'package:flutter/material.dart';
import 'package:once_front/src/screens/mywallet/cardbanner.dart';
import 'package:once_front/style.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'card_item.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  var _selectedIndex = 0;
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
          const SizedBox(height: 50),
          Container(
            // 카드 위젯 margin 및 height 정의
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 350,
            // 페이지에 따라 index 변경
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              // 카드 좌우 오버랩 설정
              controller: PageController(viewportFraction: 0.6),
              itemCount: cardBannerList.length,
              itemBuilder: (context, index) {
                var banner = cardBannerList[index];
                // 카드 선택 여부에 따라 크기 변경
                var _scale = _selectedIndex == index ? 1.0 : 0.7;

                // 크기 애니메이션 구현
                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 350),
                  tween: Tween(begin: _scale, end: _scale),
                  curve: Curves.ease,
                  child: CardItem(
                    cardBanner: banner,
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
      width: isActive ? 22.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
