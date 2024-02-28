import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:once_front/src/components/chat_bubble.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/style.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController userInputController = TextEditingController();
  String keyword = '';
  String initFormattedTime = '';
  String userInputFormattedTime = '';

  int paymentAmount = 0;

  void resetState() {
    setState(() {
      keyword = '';
      initFormattedTime = '';
      userInputFormattedTime = '';
      paymentAmount = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeTime();
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
            minimumSize: const Size(10, 20),
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

  Widget _chatArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _chatbotFirstSay("루스님, 어디서 결제하시나요?", initFormattedTime),
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
            ? _chatbotSecondSay(
                '${keyword}에서 결제하시는 군요!', userInputFormattedTime)
            : const SizedBox()
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

  @override
  Widget build(BuildContext context) {
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
                        borderSide: const BorderSide(color: Color(0xffADADAD))),
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
}
