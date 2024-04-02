import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardItem extends StatelessWidget {
  final bool isFlipped;
  final String cardImg;
  final String cardName;
  final List<Map<String, dynamic>> cardBenefitList;

  const CardItem({
    Key? key,
    required this.isFlipped,
    required this.cardImg,
    required this.cardName,
    required this.cardBenefitList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Transform(
        alignment: Alignment.center,
        transform: isFlipped ? Matrix4.rotationY(math.pi) : Matrix4.rotationY(0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: isFlipped ? Color(0xF2E5E5E5) : null,
              image: !isFlipped
                ? DecorationImage(
              image: NetworkImage(cardImg),
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: isFlipped ? CardBack(cardName: cardName, cardBenefitList: cardBenefitList, isFlipped: isFlipped) : null,
        ),
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  final String cardName;
  final List<Map<String, dynamic>> cardBenefitList;
  final bool isFlipped;

  const CardBack({
    Key? key,
    required this.cardName,
    required this.cardBenefitList,
    required this.isFlipped,
  }) : super(key: key);

  String _getIconPathForCategory(String category) {
    switch (category) {
      case "편의점":
        return "assets/images/3d_icons/convenience_store_3d_icon.svg";
      case "문화생활":
        return "assets/images/3d_icons/game_3d_icon.svg";
      case "쇼핑":
        return "assets/images/3d_icons/shopping_3d_icon.svg";
      case "카페":
        return "assets/images/3d_icons/coffee_3d_icon.svg";
      case "베이커리":
        return "assets/images/3d_icons/bakery_3d_icon.svg";
      case "교통":
        return "assets/images/3d_icons/transport_3d_icon.svg";
      default:
        return "assets/images/3d_icons/menu_3d_icon.svg"; // 차후 수정
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFECECEC),
        borderRadius: isFlipped ? BorderRadius.circular(25.0) : null,
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                cardName,
                style: TextStyle(
                  color: Color(0xFF588CFF),
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '카드 혜택',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: cardBenefitList.length,
              itemExtent: 55,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 34,
                    height: 34,
                    child: SvgPicture.asset(
                      _getIconPathForCategory(cardBenefitList[index]['category']),
                      width: 34,
                      height: 34,
                    ),
                  ),
                  title: Text(
                    cardBenefitList[index]['category'],
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  subtitle: Text(
                    cardBenefitList[index]['benefit'],
                    style: TextStyle(
                      color: Color(0xFF767676),
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
