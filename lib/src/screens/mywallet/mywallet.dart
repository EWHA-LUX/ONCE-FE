import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:once_front/style.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../constants.dart';
import '../login/loading.dart';
import 'card_item.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet>
    with SingleTickerProviderStateMixin {
  final String BASE_URL = Constants.baseUrl;
  late Future<void> _mywalletListFuture;

  int newPerformanceGoal = 0;

  var _selectedIndex = 0; // 현재 선택된 카드
  String nickname = '';
  List<Map<String, dynamic>> _cardList = [];

  // 카드 뒤집기
  double angle = 0;

  void _flip(int index) {
    setState(() {
      _isFlippedList[index] = !_isFlippedList[index];
    });
  }

  // 카드 뒤집기 여부 확인 리스트
  List<bool> _isFlippedList = [];

  void _updateState(Map<dynamic, dynamic> responseData) {
    setState(() {
      nickname = responseData['result']['nickname'];
      List<dynamic> ownedCardList = responseData['result']['ownedCardList'];
      _cardList = ownedCardList.map((card) {
        return {
          'cardName': card['cardName'],
          'cardType': card['cardType'],
          'cardImg': card['cardImg'],
          'cardCompany': card['cardCompany'],
          'isMaincard': card['isMaincard'],
          'performanceCondition': card['performanceCondition'],
          'currentPerformance': card['currentPerformance'],
          'remainPerformance': card['remainPerformance'],
          'cardBenefitList': List<Map<String, dynamic>>.from(
              card['cardBenefitList'].map((benefit) => {
                'category': benefit['category'],
                'name': benefit['name'],
                'benefit': benefit['benefit'],
              })),
        };
      }).toList();
      _isFlippedList = List.generate(
        _cardList.length,
            (index) => false,
      );
    });
  }

  // [Get] 마이월렛 조회
  Future<void> _getMyWallet(BuildContext context) async {
    final String apiUrl = '${BASE_URL}/card';

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

  // [Post] 주카드 아닌 카드 실적 입력
  Future<void> _updateCardPerformance(context, cardId, newPerformanceGoal) async {
    final String apiUrl = '${BASE_URL}/mypage/card/performance';

    const storage = FlutterSecureStorage();
    String? storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      var response =
      await dio.post(apiUrl, data: {
        "ownedCardId" : cardId,
        "performanceCondition": newPerformanceGoal
      });
      Map<dynamic, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        _getMyWallet(context);
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

  @override
  void initState() {
    super.initState();
    _mywalletListFuture = _getMyWallet(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _mywalletListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // 데이터가 로드된 후에 표시할 화면
          return _buildContent(context);
        }
      },
    );
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: const Color(0xff3B3B3B),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      duration: const Duration(seconds: 3),
      content: _snackBarContent(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {});
  }

  // 실적 입력 후 보여주는 snackbar
  Widget _snackBarContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/icons/snackbar_icon.png',
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 20.0,
          ),
          const Text(
            '실적 입력을 완료했어요.',
            style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          )
        ],
      ),
    );
  }

  @override
  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 뒤로가기 버튼
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 30.0),
                child: GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 상단 타이틀
                  const Padding(
                    padding: EdgeInsets.only(left: 28.0, top: 20.0),
                    child: Text(
                      '모든 카드 혜택을 한눈에',
                      style: TextStyles.TitleKorean,
                    ),
                  ),
                  // 알림 아이콘
                  Padding(
                    padding: const EdgeInsets.only(right: 27.0, top: 20.0),
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        'assets/images/icons/alarm_icon.svg',
                        width: 28,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed("/notification");
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          // 상단 세미 타이틀
          Padding(
            padding: const EdgeInsets.only(left: 28.0, top: 1),
            child: Text(
              '$nickname님을 위해 맞춤화된 카드 혜택 정보를 알아보세요.',
              style: TextStyles.SemiTitle,
            ),
          ),
          const SizedBox(height: 34),
          // 보유 카드 위젯
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 350,
            // 페이지에 따라 index 변경
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              // 좌우 오버랩 카드 설정
              controller: PageController(viewportFraction: 0.6),
              itemCount: _cardList.length,
              itemBuilder: (context, index) {
                var banner = _cardList[index];
                //var isFlipped = _isFlippedList[index];
                // 카드 선택 여부에 따라 크기 변경
                var _scale = _selectedIndex == index ? 1.0 : 0.7;
                //double _angle = 0;

                // 카드 스와이프 애니메이션 구현
                return GestureDetector(
                  onTap: () {
                    _flip(index);
                  },
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(
                        begin: 0, end: _isFlippedList[index] ? pi : 0),
                    duration: const Duration(seconds: 1),
                    builder: (BuildContext context, double val, __) {
                      return Transform.scale(
                        scale: _scale,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(val),
                          child: CardItem(
                            cardImg: _cardList[index]['cardImg'],
                            isFlipped: _isFlippedList[index],
                            cardName: _cardList[index]['cardName'],
                            cardCompany: _cardList[index]['cardCompany'],
                            cardBenefitList: _cardList[index]
                            ['cardBenefitList'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // 카드 인디케이터
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                _cardList.length,
                    (index) =>
                    Indicator(isActive: _selectedIndex == index ? true : false),
              )
            ],
          ),
          const SizedBox(height: 16),
          // 하단 화이트 박스 생성
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 23.0),
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                // 카드 이름
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            _cardList[_selectedIndex]['cardName'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        if (!_cardList[_selectedIndex]['isMaincard'])
                          GestureDetector(
                            child: Text(
                              "실적 입력하기 >",
                              style: const TextStyle(
                                color: Color(0xff767676),
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: const Color(0xffF7F8FC),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                        StateSetter setState) {
                                      return Container(
                                        height: 430,
                                        margin: const EdgeInsets.only(
                                          top: 20,
                                          left: 25,
                                          right: 25,
                                          bottom: 30,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Container(
                                                margin:
                                                const EdgeInsets.only(top: 7),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    color: const Color(0xffD5D7DF)),
                                                width: 48,
                                                height: 4,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 28.0, vertical: 60.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text.rich(TextSpan(children: <
                                                          TextSpan>[
                                                        TextSpan(
                                                          text: _cardList[_selectedIndex]['cardName'],
                                                          style: const TextStyle(
                                                              fontFamily:
                                                              'Pretendard',
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              color: Color(
                                                                  0xff366FFF)),
                                                        ),
                                                        const TextSpan(
                                                          text: '카드의',
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'Pretendard',
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color: Colors.black),
                                                        ),
                                                      ])),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      const Text('실적을 입력해주세요.',
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'Pretendard',
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color: Colors.black)),
                                                    ],
                                                  ),
                                                  Image.asset(
                                                    'assets/images/3d_icons/card_3d_icon.png',
                                                    width: 70,
                                                    height: 70,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 35,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  child: Image.asset(
                                                    'assets/images/icons/minus_icon.png',
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      newPerformanceGoal -= 5000;
                                                    });
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                  child: Container(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors.white),
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                    ),
                                                    child:
                                                    Text('$newPerformanceGoal 원'),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  child: Image.asset(
                                                    'assets/images/icons/plus_icon.png',
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      newPerformanceGoal += 5000;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 60,
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                width: 125,
                                                height: 37,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xff0083EE),
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                child: const Center(
                                                  child: Text('입력하기',
                                                      style: TextStyle(
                                                        fontFamily: 'Pretendard',
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                              onTap: () {
                                                _updateCardPerformance(
                                                    context, _cardList[_selectedIndex]['ownedCard_id'] ,newPerformanceGoal);
                                                Navigator.pop(context);
                                                setState(() {});
                                                showSnackBar(context);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                  });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // 남은 실적 정보
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "이번 달 실적까지 ${NumberFormat('#,###').format(_cardList[_selectedIndex]['remainPerformance'])}원 남았어요.",
                        style: const TextStyle(
                          color: Color(0xFF767676),
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // 실적 그래프
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: LinearPercentIndicator(
                        // width: 300,
                        animation: true,
                        lineHeight: 8.0,
                        animationDuration: 900,
                        percent: _cardList[_selectedIndex]
                        ['currentPerformance'] !=
                            null &&
                            _cardList[_selectedIndex]
                            ['performanceCondition'] !=
                                null
                            ? _cardList[_selectedIndex]['currentPerformance'] /
                            _cardList[_selectedIndex]
                            ['performanceCondition']
                            : 0.0,
                        barRadius: const Radius.circular(20),
                        linearGradient: const LinearGradient(
                          colors: [
                            Color(0xff5B87FD),
                            Color(0xff978EFD),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                        ),
                        backgroundColor: const Color(0xfff2f2f2),
                      ),
                    )
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
        color: isActive ? Color(0xFF4383E4) : Color(0xffAACCFF),
      ),
    );
  }
}