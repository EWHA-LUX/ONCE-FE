import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:once_front/constants.dart';
import 'package:once_front/src/components/card_list_widget.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class MaincardManage extends StatefulWidget {
  const MaincardManage({super.key});

  @override
  State<MaincardManage> createState() => _MaincardManageState();
}

class _MaincardManageState extends State<MaincardManage> {
  final String BASE_URL = Constants.baseUrl;

  int cardCount = 0;
  List<dynamic> cardList = [];

  @override
  void initState() {
    super.initState();
    _getCardList(context);
  }

  void _updateState(Map<dynamic, dynamic> responseData) {
    setState(() {
      cardCount = responseData['result']['cardCount'];
      cardList = responseData['result']['cardList'];
    });
  }

  // [Get] 카드 목록 조회
  Future<void> _getCardList(BuildContext context) async {
    final String apiUrl = '${BASE_URL}/mypage/maincard';

    const storage = FlutterSecureStorage();
    String? storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      var response = await dio.get(apiUrl);
      Map<dynamic, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        _updateState(responseData);
      }
    } catch (e) {
      // ** 차후 수정 필요 **
      print(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("오류 발생"),
            content: Text("서버와 통신 중 오류가 발생했습니다."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

  // [Patch] 주카드 해제
  Future<void> _releaseMaincard(BuildContext context, int ownedCardId) async {
    final String apiUrl = '${BASE_URL}/mypage/maincard';

    const storage = FlutterSecureStorage();
    String? storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      var response = await dio.patch('$apiUrl/$ownedCardId');
      Map<dynamic, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        setState(() {
          _getCardList(context);
        });
      }
    } catch (e) {
      // ** 차후 수정 필요 **
      print(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("오류 발생"),
            content: Text("서버와 통신 중 오류가 발생했습니다."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

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
                      children: const [
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

  // 주카드 해제 팝업 띄우기
  void showPopup(context, cardName, cardImg, cardCompany, ownedCardId) {
    showDialog(
        context: context,
        barrierDismissible: false, // 팝업 밖에는 안 눌리게
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 430,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        cardName,
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0xff0083EE),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      '주카드를 해제하시겠어요?',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 65,
                    ),
                    cardCompany == '국민카드' ||
                            cardCompany == '신한카드' ||
                            cardCompany == '하나카드' ||
                            cardCompany == '롯데카드'
                        ? Center(
                            child: Transform.rotate(
                              angle: 3.1415926535897932 / 2,
                              child: CachedNetworkImage(
                                imageUrl: cardImg,
                                width: 200,
                              ),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: cardImg,
                            width: 200,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 65.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              width: 75,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color(0xfff2f2f2),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Center(
                                child: Text(
                                  '취소',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    color: Color(0xff767676),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: Container(
                              width: 75,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color(0xff0083ee),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Center(
                                child: Text(
                                  '해제',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              _releaseMaincard(context, ownedCardId);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          );
        });
  }

  // 내 카드 목록 위젯
  Widget _cardList(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 2 - 170),
            child: Column(
              children: List.generate(cardCount, (index) {
                Map<dynamic, dynamic> card = cardList[index];
                return card['isMain']
                    ? GestureDetector(
                        child: CardListWidget(
                          ownedCardId: card['ownedCardId'],
                          isMain: card['isMain'],
                          isCreditCard: card['isCreditCard'],
                          cardName: card['cardName'],
                          cardCompany: card['cardCompany'],
                          cardImg: card['cardImg'],
                          onUpdate: () {
                            setState(() {
                              _getCardList(context);
                            });
                          },
                        ),
                        onTap: () {
                          showPopup(context, card['cardName'], card['cardImg'],
                              card['cardCompany'], card['ownedCardId']);
                        },
                      )
                    : CardListWidget(
                        ownedCardId: card['ownedCardId'],
                        isMain: card['isMain'],
                        isCreditCard: card['isCreditCard'],
                        cardName: card['cardName'],
                        cardCompany: card['cardCompany'],
                        cardImg: card['cardImg'],
                        onUpdate: () {
                          setState(() {
                            _getCardList(context);
                          });
                        },
                      );
              }),
            )),
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
