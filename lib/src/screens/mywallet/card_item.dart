import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final bool isFlipped;
  final String cardImg;
  const CardItem({
    Key? key,
    required this.isFlipped,
    required this.cardImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: isFlipped ? Color(0xF2E5E5E5) : null,
        image: !isFlipped
            ? DecorationImage(
          image: NetworkImage(cardImg),
          fit: BoxFit.cover,
        )
            : null,
      ),
    );
  }
}