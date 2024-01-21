import 'package:flutter/material.dart';
import 'package:once_front/src/screens/mywallet/cardbanner.dart';

class CardItem extends StatelessWidget {
  final CardBanner cardBanner;
  final bool isFlipped;
  const CardItem({
    Key? key,
    required this.cardBanner,
    required this.isFlipped,
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
          image: NetworkImage(cardBanner.thumbnailUrl),
          fit: BoxFit.cover,
        )
            : null,
      ),
    );
  }
}