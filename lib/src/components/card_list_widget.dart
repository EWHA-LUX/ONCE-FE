import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardListWidget extends StatelessWidget {
  bool isMain;
  bool isCreditCard;
  String cardName;
  String cardCompany;
  String cardImg;

  CardListWidget(
      {Key? key,
      required this.isMain,
      required this.isCreditCard,
      required this.cardName,
      required this.cardCompany,
      required this.cardImg})
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
          padding: const EdgeInsets.only(left: 28.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedNetworkImage(
                imageUrl: cardImg,
                width: 46,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            cardName,
                            style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(
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
                      SizedBox(
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
