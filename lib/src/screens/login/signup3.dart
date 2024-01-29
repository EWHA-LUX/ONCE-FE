import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/style.dart';

class Signup3 extends StatelessWidget {
  const Signup3({super.key});

  Widget _cardContainer(context, String cardName, String iconPath) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
            width: 110,
            height: 110,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
        SvgPicture.asset(
          iconPath,
          width: 47,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Text(
            cardName,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xff464646),
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Positioned(
                      top: 25,
                      left: 25,
                      child: GestureDetector(
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("/signup/2");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '카드 등록',
                            style: TextStyles.TitleKorean,
                          ),
                          Positioned(
                            top: 25,
                            right: 25,
                            child: Container(
                              // 상단 step 바 구현
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    const Text(
                      '혜택을 받고 싶은 카드사를 선택해주세요.',
                      style: TextStyles.SemiTitle,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width - 150 ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/images/icons/card_uncheck_icon.svg",
                    width: 18,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    '전체 카드사 선택',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _cardContainer(context, "신한카드", "assets/images/card_logo/shinhan_logo.svg"),
                            _cardContainer(context, "현대카드", "assets/images/card_logo/hyundai_logo.svg"),
                            _cardContainer(context, "국민카드", "assets/images/card_logo/kookmin_logo.svg"),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _cardContainer(context, "삼성카드", "assets/images/card_logo/samsung_logo.svg"),
                            _cardContainer(context, "롯데카드", "assets/images/card_logo/lotte_logo.svg"),
                            _cardContainer(context, "하나카드", "assets/images/card_logo/hana_logo.svg"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 300,
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 177.5 ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 45,
                        width: 355,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.topLeft,
                            colors: [
                              Color(0xff5B87FD),
                              Color(0xff978EFD),
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(20)
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            '카드 검색',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed("/signup/4");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}