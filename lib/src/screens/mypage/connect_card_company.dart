import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_front/constants.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/style.dart';


class ConnectCardCompany extends StatefulWidget {
  const ConnectCardCompany({Key? key}) : super(key: key);

  @override
  _ConnectCardCompanyState createState() => _ConnectCardCompanyState();
}

class _ConnectCardCompanyState extends State<ConnectCardCompany> {
  final String BASE_URL = Constants.baseUrl;
  List<dynamic> cardList = [];

  @override
  void initState() {
    super.initState();
    _getCardList(context);
  }

  void _updateState(Map<dynamic, dynamic> responseData) {
    setState(() {
      cardList = List<Map<String, dynamic>>.from(responseData['result'])
          .map((item) => {
                'cardCompanyName': item['cardCompanyName'],
                'connectedAt': item['connectedAt'],
              })
          .toList();
    });
  }

  List<bool> isCardSelectedList = List.generate(6, (index) => false);
  bool isAllSelected = false;
  int? selectedCardIndex;

  void _updateSelectedCard(int index) {
    setState(() {
      if (selectedCardIndex == index) {
        selectedCardIndex = null;
      } else {
        selectedCardIndex = index;
        for (int i = 0; i < isCardSelectedList.length; i++) {
          if (i != index) {
            isCardSelectedList[i] = false;
          }
        }
        // 선택한 카드사에 해당하는 스낵바 표시
        showModalBottomSheet(
            context: context,
            backgroundColor: const Color(0xffF7F8FC),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 430,
                  margin: const EdgeInsets.only(
                    top: 20,
                    left: 25,
                    right: 25,
                    bottom: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffD5D7DF)),
                          width: 48,
                          height: 4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text: _getCardCompanyName(index),
                                    style: const TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff366FFF)),
                                  ),
                                ])),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text('카드사 연결하시겠어요?',
                                    style: TextStyle(
                                        fontFamily: 'Pretendard',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black)),
                              ],
                            ),
                            SvgPicture.asset(
                              _getIconPathForCompany(index),
                              width: 70,
                              height: 70,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 270,
                        child: TextFormField(
                          //controller: loginIdController,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/images/icons/id_icon.svg',
                                width: 15,
                                height: 15,
                              ),
                            ),
                            hintText: 'ID',
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                            isCollapsed: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 40,
                        width: 270,
                        child: TextField(
                          //controller: passwordController,
                          obscureText: true,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/images/icons/password_icon.svg',
                                width: 15,
                                height: 15,
                              ),
                            ),
                            hintText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                            isCollapsed: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                        child: Container(
                          width: 125,
                          height: 37,
                          decoration: BoxDecoration(
                            color: const Color(0xff0083EE),
                            borderRadius: BorderRadius.circular(20),
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
                          //_updateBenefitGoal(context, newBenefitGoal);
                          //Navigator.pop(context);
                          setState(() {});
                        },
                      )
                    ],
                  ),
                );
              });
            });
      }
    });
  }

  // [Get] 카드사 연결 현황
  Future<void> _getCardList(BuildContext context) async {
    final String apiUrl = '${BASE_URL}/card/connect';

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
  String _getIconPathFromCompanyName(String name) {
    switch (name) {
      case "신한카드":
        return "assets/images/card_logo/shinhan_logo.svg";
      case "현대카드":
        return "assets/images/card_logo/hyundai_logo.svg";
      case "국민카드":
        return "assets/images/card_logo/kookmin_logo.svg";
      case "삼성카드":
        return "assets/images/card_logo/samsung_logo.svg";
      case "롯데카드":
        return "assets/images/card_logo/lotte_logo.svg";
      case "하나카드":
        return "assets/images/card_logo/hana_logo.svg";
      default:
        return "";
    }
  }

  String _getIconPathForCompany(int index) {
    switch (index) {
      case 0:
        return "assets/images/card_logo/shinhan_logo.svg";
      case 1:
        return "assets/images/card_logo/hyundai_logo.svg";
      case 2:
        return "assets/images/card_logo/kookmin_logo.svg";
      case 3:
        return "assets/images/card_logo/samsung_logo.svg";
      case 4:
        return "assets/images/card_logo/lotte_logo.svg";
      case 5:
        return "assets/images/card_logo/hana_logo.svg";
      default:
        return "";
    }
  }

  String _getCardCompanyName(int index) {
    switch (index) {
      case 0:
        return "신한카드";
      case 1:
        return "현대카드";
      case 2:
        return "국민카드";
      case 3:
        return "삼성카드";
      case 4:
        return "롯데카드";
      case 5:
        return "하나카드";
      default:
        return "";
    }
  }

  Widget _cardContainer(int index, String cardName, String iconPath) {
    return InkWell(
      onTap: () {
        _updateSelectedCard(index);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: (selectedCardIndex == index)
                  ? const Color(0xffdceefd)
                  : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular((selectedCardIndex == index) ? 20 : 20),
              ),
              border: Border.all(
                color: (selectedCardIndex == index)
                    ? const Color(0xff3d6dc4)
                    : Colors.transparent,
                width: 1,
              ),
            ),
          ),
          Column(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 47,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                cardName,
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff464646),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 상단 뒤로가기 버튼
  Widget _stepArea(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/codef");
            },
          ),
        ],
      ),
    );
  }

  Widget _infoArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '카드사 연결',
                style: TextStyles.TitleKorean,
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                '현재는 6개의 카드사만 연결할 수 있어요.',
                style: TextStyles.SemiTitle,
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            'assets/images/3d_icons/rocket_3d_icon.svg',
            width: 109,
            height: 109,
          ),
        ],
      ),
    );
  }

  Widget _cardCompanyList() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Container(
            height: 250,
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Positioned(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _cardContainer(0, "신한카드",
                                "assets/images/card_logo/shinhan_logo.svg"),
                            _cardContainer(1, "현대카드",
                                "assets/images/card_logo/hyundai_logo.svg"),
                            _cardContainer(2, "국민카드",
                                "assets/images/card_logo/kookmin_logo.svg"),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _cardContainer(3, "삼성카드",
                                "assets/images/card_logo/samsung_logo.svg"),
                            _cardContainer(4, "롯데카드",
                                "assets/images/card_logo/lotte_logo.svg"),
                            _cardContainer(5, "하나카드",
                                "assets/images/card_logo/hana_logo.svg"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cardList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Row(
              children: [
                SizedBox(width: 15),
                SvgPicture.asset(
                  _getIconPathFromCompanyName(cardList[index]['cardCompanyName']),
                  width: 55,
                  height: 55,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cardList[index]['cardCompanyName'],
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        cardList[index]['connectedAt'] + ' 연결',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                          color: const Color(0xff0083EE),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _navigateToCardCompanyWebsite(cardList[index]['cardCompanyName']);
                  },
                  child: SvgPicture.asset(
                    'assets/images/icons/card_company_link_arrow_icon.svg',
                    width: 22,
                    height: 22,
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          );
        },
      ),
    );
  }

  // 카드사별 URL 반환 함수
  String _navigateToCardCompanyWebsite(String name) {
    switch (name) {
      case "신한카드":
        return "https://www.shinhancard.com/pconts/html/main.html?utm_source=google&utm_medium=sa&utm_campaign=homepage_pc_B_main&utm_content=finance&utm_term=%EC%8B%A0%ED%95%9C%EC%B9%B4%EB%93%9C&gad_source=1&gclid=CjwKCAjw9IayBhBJEiwAVuc3flged3Rbo52HWdN5G8_tLIud24084eUbyeL55yge9UXB66koTMoDLRoCyIUQAvD_BwE";
      case "현대카드":
        return "https://www.hyundaicard.com/index.jsp";
      case "국민카드":
        return "https://card.kbcard.com/CMN/DVIEW/HOAMCXPRIZZC0002";
      case "삼성카드":
        return "https://www.samsungcard.com/personal/main/UHPPCO0101M0.jsp";
      case "롯데카드":
        return "https://www.lottecard.co.kr/app/LPMAIAA_V100.lc?referrer=https%3A%2F%2Fwww.google.com%2F";
      case "하나카드":
        return "https://www.hanacard.co.kr/OPI21000000D.web?schID=pcd&mID=OPI21000000P&keyword=%ED%95%98%EB%82%98%EC%B9%B4%EB%93%9C&gad_source=1&gclid=CjwKCAjw9IayBhBJEiwAVuc3fvC6RzbyBDXOV0erhmeXRvytTvxqg956iXtnsZWxaQuwKltQfutsyxoCI08QAvD_BwE";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _stepArea(context),
          _infoArea(),
          _cardCompanyList(),
          Padding(
            padding:
            const EdgeInsets.only(top: 40.0, left: 25.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
              '연결된 카드사 목록',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black,
              ),
              ),
              ],
            ),
          ),
          _cardList(context),
        ],
      ),
    );
  }
}
