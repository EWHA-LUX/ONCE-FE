import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:once_front/constants.dart';
import 'package:once_front/src/components/chat_bubble.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/src/screens/login/loading.dart';
import 'package:once_front/style.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ==================== API 통신 ====================
  final String BASE_URL = Constants.baseUrl;

  bool isRecommend = false;

  String nickname = '';
  int ownedCardCount = 0;
  List<dynamic> keywordList = [];

  int chatId = 0;
  String cardName = '';
  String cardImg = '';
  String benefit = '';
  int discount = 0;

  late Future<void> _homeInfoFuture; // 홈 기본 정보
  late Future<void> _cardRecommendFuture; // 카드 추천

  @override
  void initState() {
    super.initState();
    initializeTime();
    _homeInfoFuture = _homeInfo(context);
  }

  void _updateHomeInfoState(Map<dynamic, dynamic> responseData) {
    setState(() {
      nickname = responseData['result']['nickname'];
      ownedCardCount = responseData['result']['ownedCardCount'];
      keywordList = responseData['result']['keywordList'];
    });
  }

  void _updateCardRecommendState(Map<dynamic, dynamic> responseData) {
    setState(() {
      isRecommend = true;
      cardName = responseData['result']['cardName'];
      cardImg = responseData['result']['cardImg'];
      benefit = responseData['result']['benefit'];
      discount = responseData['result']['discount'];
    });
  }

  // [Get] 홈화면 기본 정보
  Future<void> _homeInfo(BuildContext context) async {
    final String apiUrl = '${BASE_URL}/home/basic';

    const storage = FlutterSecureStorage();
    String? storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    var response = await dio.get(apiUrl);
    Map<dynamic, dynamic> responseData = response.data;
    print(responseData);

    if (responseData['code'] == 1000) {
      _updateHomeInfoState(responseData);
    }
  }

  // [Get] 챗봇 카드 추천
  Future<void> _cardRecommend(BuildContext context, String keyword,
      int paymentAmount) async {
    final String apiUrl = '${BASE_URL}/home';

    const storage = FlutterSecureStorage();
    String? storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      var response = await dio.get(apiUrl, queryParameters: {
        'keyword': keyword,
        'paymentAmount': paymentAmount
      });
      Map<dynamic, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        _updateCardRecommendState(responseData);
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

  // ==================== 챗봇 대화 입력 ====================
  TextEditingController userInputController = TextEditingController();
  String keyword = '';
  String initFormattedTime = '';
  String userInputFormattedTime = '';

  int paymentAmount = 0;

  void resetState() {
    setState(() {
      isRecommend = false;
      keyword = '';
      initFormattedTime = '';
      userInputFormattedTime = '';
      paymentAmount = 0;
    });
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void initializeTime() {
    var now = DateTime.now();
    initFormattedTime = DateFormat('HH:mm').format(now);
    setState(() {});
  }

  // 사용자 keyword 입력 시간
  void userInputTime() {
    var now = DateTime.now();
    userInputFormattedTime = DateFormat('HH:mm').format(now);
    setState(() {});
  }

  Widget _information(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 28.0, top: 35.0),
          child: GestureDetector(
            child: const Text(
              'ONCE',
              style: TextStyles.TitleEnglish,
            ),
            onTap: () {
              resetState();
              initializeTime();
              setState(() {});
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 28.0, top: 1),
              child: Text(
                '결제 전 가장 혜택이 좋은 카드를 추천드려요.',
                style: TextStyles.SemiTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 27),
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/images/icons/alarm_icon.svg',
                  width: 28,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/notification");
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  // user 결제처 입력 대화
  Widget _userSay(String userText, String now) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 8.0),
          child: Text(
            now,
            style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 12,
                color: Color(0xffA5A5A5)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: CustomPaint(
            painter: ChatBubble(
              color: Colors.white,
              alignment: Alignment.topRight,
            ),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      userText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Pretenard',
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 챗봇 - 결제처 물어보는 대화
  Widget _chatbotFirstSay(String chatbotText, String now) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 10.0),
          child: SvgPicture.asset(
            'assets/images/icons/chatbot_icon.svg',
            width: 30,
          ),
        ),
        CustomPaint(
          painter: ChatBubble(
            color: const Color(0xff0083EE),
            alignment: Alignment.topLeft,
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    chatbotText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pretenard',
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 8.0),
          child: Text(
            now,
            style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 12,
                color: Color(0xffA5A5A5)),
          ),
        )
      ],
    );
  }

  // 결제 금액 증가 함수
  void _incrementAmount(int amount) {
    setState(() {
      paymentAmount += amount;
    });
  }

  // 결제 금액 초기화
  void _resetAmount() {
    setState(() {
      paymentAmount = 0;
    });
  }

  // 결제금액 입력 버튼
  Widget _priceButton(String priceText, int price) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.all(8),
            minimumSize: Size(10, 20),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0))),
        onPressed: () {
          _incrementAmount(price);
        },
        child: Text(priceText,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 13,
              color: Color(0xff939393),
            )),
      ),
    );
  }

  // 결제 금액 입력 완료 버튼
  Widget _finishButton(String finishText) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          side: const BorderSide(color: Color(0xff939393)),
          padding: const EdgeInsets.all(6),
          minimumSize: const Size(10, 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      onPressed: () {
        // 카드 추천 API - keyword, price
        _cardRecommend(context, keyword, paymentAmount);
      },
      child: Text(finishText,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 13,
            color: Color(0xff939393),
          )),
    );
  }

  // 챗봇 - 결제금액 입력 받는 대화
  Widget _chatbotSecondSay(String chatbotText, String now) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 10.0),
              child: SvgPicture.asset(
                'assets/images/icons/chatbot_icon.svg',
                width: 30,
              ),
            ),
            CustomPaint(
              painter: ChatBubble(
                color: const Color(0xff0083EE),
                alignment: Alignment.topLeft,
              ),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        chatbotText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pretenard',
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 8.0),
              child: Text(
                now,
                style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    color: Color(0xffA5A5A5)),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 65.0),
          child: Container(
            margin: const EdgeInsets.only(top: 8, right: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$paymentAmount원',
                  style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  child: Image.asset(
                    'assets/images/icons/x_button.png',
                    width: 20,
                    height: 20,
                  ),
                  onTap: () {
                    _resetAmount();
                  },
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 65,
                ),
                _priceButton('+ 1천원', 1000),
                _priceButton('+ 5천원', 5000),
                _priceButton('+ 1만원', 10000),
                _priceButton('+ 5만원', 50000),
                _finishButton('완료')
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _keywordBox(String keywordText) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 5.0),
      child: GestureDetector(
        child: Container(
          height: 30,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xff0083EE),
              ),
              borderRadius: BorderRadius.circular(13)),
          child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(keywordText),
              )),
        ),
        onTap: () {
          setState(() {
            keyword = keywordText;
          });
        },
      ),
    );
  }

  Widget _cardRecommendBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 35.0, right: 35.0),
      child: Column(
        children: [
          Container(
            height: 40,
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
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: Center(
              child: Text.rich(
                  TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: '$ownedCardCount개의 카드 중',
                      style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const TextSpan(
                      text: ' 가장 좋은 카드 하나',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const TextSpan(
                      text: '를 알려드려요.',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ])

              ),
            ),
          ),
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(13),
                bottomRight: Radius.circular(13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _chatbotFirstSay("$nickname님, 어디서 결제하시나요?", initFormattedTime),
        Padding(
          padding: const EdgeInsets.only(left: 75.0),
          child: Row(
            children: [
              _keywordBox(keywordList[0]),
              _keywordBox(keywordList[1]),
              _keywordBox(keywordList[2]),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        keyword.isNotEmpty
            ? _userSay(keyword, userInputFormattedTime)
            : const SizedBox(),
        const SizedBox(
          height: 20,
        ),
        keyword.isNotEmpty
            ? _chatbotSecondSay('$keyword에서 결제하시는 군요!', userInputFormattedTime)
            : const SizedBox(),
        isRecommend ? _cardRecommendBox() : const SizedBox()
      ],
    );
  }

  // bottomsheet 아이콘 위젯
  Widget _navbarCircle(String imagePath, String menuName) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xffeeeeee)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: SizedBox(
              width: 40,
              height: 40,
              child: SvgPicture.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            menuName,
            style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  Widget homeUI(context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        children: [
          _information(context),
          const SizedBox(
            height: 20,
          ),
          _chatArea()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      builder: (BuildContext context) {
                        return Container(
                            height: 230,
                            margin: const EdgeInsets.only(
                              top: 20,
                              left: 25,
                              right: 25,
                              bottom: 30,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      child: const Icon(Icons.close),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  // 마이월렛, 월별혜택조회, 마이페이지
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: _navbarCircle(
                                          'assets/images/3d_icons/wallet_3d_icon.svg',
                                          '마이월렛'),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed("/mywallet");
                                      },
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    GestureDetector(
                                      child: _navbarCircle(
                                          'assets/images/3d_icons/graph_3d_icon.svg',
                                          '월별 혜택 조회'),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed("/mypage/benefit");
                                      },
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    GestureDetector(
                                      child: _navbarCircle(
                                          'assets/images/3d_icons/mypage_3d_icon.svg',
                                          '마이페이지'),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed("/mypage");
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Row(
                                    // 설정, 로그아웃
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: _navbarCircle(
                                            'assets/images/3d_icons/setting_3d_icon.svg',
                                            '설정'),
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed("/setting");
                                        },
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      GestureDetector(
                                        child: _navbarCircle(
                                            'assets/images/3d_icons/logout_3d_icon.svg',
                                            '로그아웃'),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      });
                },
                child: SvgPicture.asset(
                  "assets/images/icons/menu_icon.svg",
                  width: 35,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: TextField(
                    controller: userInputController,
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            child: SvgPicture.asset(
                              "assets/images/icons/send_icon.svg",
                              width: 10,
                            ),
                            onTap: () {
                              userInputTime();
                              setState(() {
                                keyword = userInputController.text;
                                userInputController.clear();
                              });
                            },
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color(0xffADADAD))),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        hintText: '궁금한 것을 질문해 보세요.',
                        hintStyle: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffADADAD))),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _homeInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // 데이터가 로드된 후에 표시할 화면
          return homeUI(context);
        }
      },
    );
  }
}
