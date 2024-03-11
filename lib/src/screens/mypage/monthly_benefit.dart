import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:once_front/constants.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/svg.dart';

import '../login/loading.dart';

class MonthlyBenefit extends StatefulWidget {
  MonthlyBenefit({Key? key}) : super(key: key);

  @override
  _MonthlyBenefitState createState() => _MonthlyBenefitState();
}

class _MonthlyBenefitState extends State<MonthlyBenefit> {
  final String BASE_URL = Constants.baseUrl;
  late Future<void> _montlyBenefitListFuture;

  String nickname = '';
  int benefitGoal = 0;
  int newBenefitGoal = 0;

  DateTime dt = DateTime.now();
  int? _month;
  num? _receivedSum;
  int? _remainBenefit;
  late List<dynamic> _benefitList = [];

  @override
  void initState() {
    super.initState();
    dt = DateTime.now();
    _month = dt.month;
    _montlyBenefitListFuture = _getMontlyBenefit(context);
    _getUserInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _montlyBenefitListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // 데이터가 로드된 후에 표시할 화면
          return buildContents(context);
        }
      },
    );
  }

  void _updateState(Map<dynamic, dynamic> responseData) {
    setState(() {
      nickname = responseData['result']['nickname'];
      benefitGoal = responseData['result']['benefitGoal'];
      newBenefitGoal = benefitGoal;
    });
  }

  void _updateBenefitState(Map<dynamic, dynamic> responseData) {
    setState(() {
      var result = responseData['result'];
      var benefitList = result['benefitList'];

      if (benefitList != null && benefitList.isNotEmpty) {
        _benefitList = benefitList.map((benefit) {
          return {
            'category': benefit['category'],
            'discountPriceSum': benefit['discountPriceSum'],
            'priceSum': benefit['priceSum'],
          };
        }).toList();
      } else {
        _benefitList = [];
      }

      _month = result['month'] as int?;
      _receivedSum = result['receivedSum'] ?? 0;
      _remainBenefit = result['remainBenefit'] ?? 0;
    });
  }

  // [Get] 월별 혜택 조회
  Future<void> _getMontlyBenefit(BuildContext context) async {
    final String apiUrl = '${BASE_URL}/card/benefit?month=$_month';

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
        _updateBenefitState(responseData);
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

  // [Post] 목표 금액 변경
  Future<void> _updateBenefitGoal(context, newBenefitGoal) async {
    final String apiUrl = '${BASE_URL}/card/benefitgoal';

    const storage = FlutterSecureStorage();
    String? storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      var response =
      await dio.post(apiUrl, data: {"benefitGoal": newBenefitGoal});
      Map<dynamic, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        _getUserInfo(context);
        _getMontlyBenefit(context);
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

  // [Get] 유저 정보 가져오기
  Future<void> _getUserInfo(BuildContext context) async {
    final String apiUrl = '${BASE_URL}/mypage';

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

  Widget _gradationBody(context) {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            // 상단 그라데이션 배경
            height: 560,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color(0xff4472fc),
                    Color(0xff8877d5),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(300.0, 130.0),
                  bottomRight: Radius.elliptical(300.0, 130.0),
                )),
          ),
          // 뒤로가기 버튼
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 월별 혜택 조회 타이틀
              const Padding(
                padding: EdgeInsets.only(left: 28.0, top: 70),
                child: Text('월별 혜택 조회',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                      color: Colors.white,
                    )),
              ),
              // 알림 이동하기
              Padding(
                padding: const EdgeInsets.only(right: 28.0, top: 70),
                child: GestureDetector(
                  child: SvgPicture.asset(
                    'assets/images/icons/alarm_icon.svg',
                    width: 28,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/notification");
                  },
                ),
              ),
            ],
          ),
          // 월별 혜택 조회 세미 타이틀
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 110),
            child: Text('이번 달 원스로 받은 모든 혜택을 알려드려요.',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xE8DEDEDE),
                )),
          ),
          // 혜택 조회 상단 화이트 박스
          Positioned(
            top: 160,
            left: MediaQuery
                .of(context)
                .size
                .width / 2 - 170,
            child: Container(
              width: 340,
              height: 230,
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
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Text(
                          '$_month월의 혜택',
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // 목표 수정하기 버튼
                      GestureDetector(
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10.0, right: 20.0),
                          child: Icon(
                            Icons.more_horiz,
                            color: Color(0xffc2c2c2),
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
                                                      text: '$nickname ',
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
                                                      text: '님,',
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
                                                  const Text('목표를 변경하시겠어요?',
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
                                                'assets/images/3d_icons/target_3d_icon.png',
                                                width: 70,
                                                height: 70,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Text.rich(
                                              TextSpan(children: <TextSpan>[
                                                const TextSpan(
                                                  text: '현재 목표 금액은 ',
                                                  style: TextStyle(
                                                      fontFamily: 'Pretendard',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w400,
                                                      color: Colors.black),
                                                ),
                                                TextSpan(
                                                  text: '$benefitGoal원 ',
                                                  style: const TextStyle(
                                                      fontFamily: 'Pretendard',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      color: Colors.black),
                                                ),
                                                const TextSpan(
                                                  text: '이에요!',
                                                  style: TextStyle(
                                                      fontFamily: 'Pretendard',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w400,
                                                      color: Colors.black),
                                                ),
                                              ])),
                                        ),
                                        const SizedBox(
                                          height: 25,
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
                                                  newBenefitGoal -= 5000;
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
                                                Text('$newBenefitGoal 원'),
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
                                                  newBenefitGoal += 5000;
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
                                              child: Text('변경하기',
                                                  style: TextStyle(
                                                    fontFamily: 'Pretendard',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                          onTap: () {
                                            _updateBenefitGoal(
                                                context, newBenefitGoal);
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
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      _remainBenefit != null && _remainBenefit! > 0
                          ? '이번 달 목표까지 ${NumberFormat('#,###').format(_remainBenefit!)}원 부족해요.'
                          : _remainBenefit! < 0
                              ? '목표를 달성했습니다.'
                              : '목표를 입력해주세요.',
                      style: const TextStyle(

                        fontFamily: 'Pretendard',
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Color(0xff767676),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .width / 2 - 130,
                            top: 20.0),
                        child: Container(
                          child: Circular_arc(
                            key: UniqueKey(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .width / 2 - 75,
                            top: 40.0),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/3d_icons/coins_3d_icon.svg',
                              width: 80,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${NumberFormat('#,###').format(_receivedSum)}원 할인',
                              style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 430),
            child: Text(
              '혜택 자세히 보기',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================================
  // 목표 변경 후 보여주는 snackbar
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
            '목표 수정을 완료했어요.',
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

  // =============================================================================

  Widget _benefitCategory(context, String iconPath, String category,
      String benefitAmout, String benefit, double percent) {
    return Center(
      child: Container(
        width: 340,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xffefefef),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    width: 30,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 카테고리
                          Text(
                            category,
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          // 해당 카테고리에서 받은 혜택
                          Text(
                            benefitAmout + ' 원',
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // 카테고리별 할인 정보
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '할인 : $benefit 원',
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff737373),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // 카테고리별 실적 그래프
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: LinearPercentIndicator(
                        width: 220,
                        animation: true,
                        lineHeight: 6,
                        animationDuration: 900,
                        percent: percent,
                        barRadius: Radius.circular(20),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContents(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _gradationBody(context),
            Padding(
              padding: const EdgeInsets.only(top: 460.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ..._buildBenefitCategories(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBenefitCategories() {
    if (_benefitList != null && _benefitList.isNotEmpty) {
      return _benefitList.map((benefit) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 13.0),
          child: _benefitCategory(
            context,
            _getIconPathForCategory(benefit['category']),
            benefit['category'],
            _formatCurrency(benefit['priceSum']),
            _formatCurrency(benefit['discountPriceSum']),
            (benefit['discountPriceSum'] / benefit['priceSum']),
          ),
        );
      }).toList();
    } else {
      return [];
    }
  }

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
        return "";
    }
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat("#,###");
    return formatter.format(amount);
  }
}

class Circular_arc extends StatefulWidget {
  const Circular_arc({
    required Key key,
  }) : super(key: key);

  @override
  _Circular_arcState createState() => _Circular_arcState();
}

// 월별 혜택 조회 progress bar 애니메이션
class _Circular_arcState extends State<Circular_arc>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    final curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutCubic);

    animation = Tween<double>(begin: 0.0, end: 2.3).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      colors: [
        Color(0xff5B87FD),
        Color(0xff978EFD),
      ],
    );

    LinearGradient whitegradient = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      colors: [
        Color(0xfff2f2f2),
        Color(0xfff2f2f2),
      ],
    );

    return Stack(
      children: [
        CustomPaint(
          size: const Size(130, 130),
          painter: ProgressArc(3.14, whitegradient, false),
        ),
        CustomPaint(
          size: const Size(130, 130),
          painter: ProgressArc(animation.value, gradient, false),
        ),
      ],
    );
  }
}

// 월별 혜택 조회 arc progress bar 그리기
class ProgressArc extends CustomPainter {
  bool isBackGround;
  double arc;
  Gradient progressColor;

  ProgressArc(this.arc, this.progressColor, this.isBackGround);

  @override
  void paint(Canvas canvas, Size size) {
    const rect = Rect.fromLTRB(0, 0, 210, 210);
    const startAngle = -pi;
    final sweepAngle = arc ?? pi;
    const userCenter = false;
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    if (!isBackGround) {
      paint.shader = progressColor.createShader(rect);
    }
    canvas.drawArc(rect, startAngle, sweepAngle, userCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
