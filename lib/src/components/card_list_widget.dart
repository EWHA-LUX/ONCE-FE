import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardListWidget extends StatelessWidget {
  bool isMain;
  bool isCreditCard;
  String cardName;
  String cardCompany;
  String cardImg;
  int ownedCardId;

  CardListWidget(
      {Key? key,
      required this.isMain,
      required this.isCreditCard,
      required this.cardName,
      required this.cardCompany,
      required this.cardImg,
      required this.ownedCardId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 340,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              cardCompany == '국민카드' ||
                      cardCompany == '신한카드' ||
                      cardCompany == '하나카드' ||
                      cardCompany == '롯데카드'
                  ? Transform.rotate(
                      angle: 3.1415926535897932 / 2, // 90 degrees in radians
                      child: CachedNetworkImage(
                        imageUrl: cardImg,
                        width: 63,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 10),
                      child: CachedNetworkImage(
                        imageUrl: cardImg,
                        width: 41,
                      ),
                    ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 140,
                            child: Text(
                              cardName,
                              style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          isMain
                              ? Image.asset(
                                  'assets/images/icons/crown_icon.png',
                                  width: 15,
                                  height: 15,
                                )
                              : SizedBox(width: 0)
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "# ${cardCompany} # ${isCreditCard ? "신용카드" : "체크카드"}",
                        style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff767676)),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  width: 40,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Color(0xfff2f2f2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      '삭제',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Color(0xffFF7070),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
