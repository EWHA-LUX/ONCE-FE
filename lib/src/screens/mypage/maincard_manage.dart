import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:once_front/src/components/card_list_widget.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class MaincardManage extends StatelessWidget {
  const MaincardManage({super.key});

  Widget _gradationBody(context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          // 상단 그라데이션 베경
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xff4472fc),
                Color(0xff8877d5),
              ],
            ),
          ),
        ),
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
        Positioned(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          '주카드 관리',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                              color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        child: SvgPicture.asset(
                          'assets/images/icons/alarm_icon.svg',
                          width: 28,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("/notification");
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  '원스에서 관리받고 싶은 주카드를 등록해 보세요.',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xffe8e8e8)),
                ),
              ],
            ),
          ),
        ),
        // 주카드 추가하기
        Positioned(
          top: 160,
          left: MediaQuery.of(context).size.width / 2 - 180,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/codef");
            },
            child: Container(
              width: 360,
              height: 120,
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
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '카드 추가하기',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '10초 만에 새로운 카드 연동하러 가기',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Color(0xff4e4e4e)),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      "assets/images/3d_icons/menu_3d_icon.svg",
                      width: 80,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 내 카드 목록 위젯
  Widget _cardList(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 2 - 170),
          child: Column(
            children: [
              CardListWidget(
                  isMain: true,
                  isCreditCard: true,
                  cardName: "M BOOST",
                  cardCompany: "현대카드",
                  cardImg:
                      "https://img.hyundaicard.com/img/com/card/card_M3PBT_h.png"),
              CardListWidget(
                  isMain: false,
                  isCreditCard: true,
                  cardName: "ZERO Edition2",
                  cardCompany: "현대카드",
                  cardImg:
                      "https://img.hyundaicard.com/img/com/card/card_MZROE2_h.png"),
              CardListWidget(
                  isMain: false,
                  isCreditCard: true,
                  cardName: "M Edition3",
                  cardCompany: "현대카드",
                  cardImg:
                      "https://img.hyundaicard.com/img/com/card/card_MSKTE3_h.png"),
              CardListWidget(
                  isMain: false,
                  isCreditCard: false,
                  cardName: "카드의정석 EVERY CHECK",
                  cardCompany: "우리카드",
                  cardImg:
                      "https://pc.wooricard.com/webcontent/cdPrdImgFileList/2023/7/17/f7886e80-e7cb-4f54-b30c-bf9bd0a351f4.gif"),
              CardListWidget(
                  isMain: false,
                  isCreditCard: true,
                  cardName: "LOCA LIKIT Shop",
                  cardCompany: "롯데카드",
                  cardImg:
                      "https://image.lottecard.co.kr/UploadFiles/ecenterPath/cdInfo/ecenterCdInfoP13955-A13955_nm1_v.png"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        appBar: EmptyAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _gradationBody(context),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 25.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '내 카드 목록',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '더 이상 사용하지 않는 카드는 삭제할 수 있어요.',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Color(0xff767676)),
                  ),
                ],
              ),
            ),
            _cardList(context),
          ],
        ));
  }
}
