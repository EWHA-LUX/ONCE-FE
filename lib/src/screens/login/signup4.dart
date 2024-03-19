import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/style.dart';

import '../../../constants.dart';

class Signup4 extends StatefulWidget {
  const Signup4({Key? key}) : super(key: key);

  @override
  _Signup4State createState() => _Signup4State();
}

class _Signup4State extends State<Signup4> {
  final String BASE_URL = Constants.baseUrl;
  late List<int> selectedCardIndex;

  // [Get] 카드사로 카드 검색
  Future<void> _getCardDetails(BuildContext context, List<int> selectedCardIndex) async {
    print(selectedCardIndex);
    final List<String> cardCodes = selectedCardIndex.map((index) {
      switch (index) {
        case 0:
          return '0306';
        case 1:
          return '0302';
        case 2:
          return '0301';
        case 3:
          return '0303';
        case 4:
          return '0311';
        case 5:
          return '0313';
        default:
          return '';
      }
    }).toList();

    final String apiUrl = '$BASE_URL/user/card/search';

    final baseOptions = BaseOptions(
    );

    final dio = Dio(baseOptions);

    try {
      String queryString = 'code=' + cardCodes.join(',');
      String apiUrlWithQuery = apiUrl + '?' + queryString;

      var response = await dio.get(apiUrlWithQuery);
      Map<dynamic, dynamic> responseData = response.data;

      if (responseData['code'] == 1000) {
        final List<dynamic> cardDetails = responseData['result'];

        for (var cardDetail in cardDetails) {
          String companyName = cardDetail['companyName'];
          List<dynamic> cardList = cardDetail['cardList'];

          for (var card in cardList) {
            String cardId = card['cardId'].toString();
            String cardName = card['cardName'];
            String cardImg = card['cardImg'];

            print('Card ID: $cardId, Name: $cardName, Image URL: $cardImg');
          }
        }
      }
    } catch (e) {
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
    selectedCardIndex = []; // 선택된 카드 인덱스 초기화
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      selectedCardIndex = ModalRoute.of(context)!.settings.arguments as List<int>;
      _getCardDetails(context, selectedCardIndex);
    });
  }

  List<bool> isCardSelectedList = List.generate(6, (index) => false);
  List<bool> isCardCompanyList = List.generate(3, (index) => false);
  List<String> filteredCardNames = [];

  TextEditingController _searchController = TextEditingController();
  String _selectedCardCompany = "현대카드";

  // 선택된 상단탭 카드사
  // 처음에 1번 탭에 있는 카드사가 무조건 선택되도록 설정
  int _selectedCardCompanyIndex = 0;

  _Signup4State() {
    isCardCompanyList[0] = true;
  }

  List<String> allCardNames = [
    '현대카드 M Boost',
    '현대카드 ZERO Edition2',
    '현대카드M Edition3',
    '우리동네 GS 삼성카드',
    '국만행복 삼성체크카드 v2',
    '삼성카드 원스원스 카드',
    '삼성카드 루스루스 카드',
    '삼성카드M Example 카드',
    '삼성카드 S7 카드',
    '삼성카드 원스체크카드 v2',
  ];

  // 카드 이름 검색창
  void filterCardNames(String query) {
    setState(() {
      filteredCardNames = allCardNames
          .where((cardName) =>
              cardName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // 카드 회사명 상단 탭
  Widget _cardCompany(int index, String iconPath, String cardCompany) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        // 카드사는 한번에 하나만 선택할 수 있도록 설정
        // 다른 카드사를 탭 -> 현재 카드사 선택 해제 -> 선택한 카드사 선택됨
        onTap: () {
          setState(() {
            if (_selectedCardCompanyIndex != -1) {
              isCardCompanyList[_selectedCardCompanyIndex] = false;
            }
            _selectedCardCompany = cardCompany;
            _selectedCardCompanyIndex = index;
            isCardCompanyList[index] = true;
          });
        },

        child: Container(
          width: 93,
          height: 31,
          decoration: BoxDecoration(
            color: isCardCompanyList[index]
                ? const Color(0xffdceefd)
                : Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(isCardCompanyList[index] ? 13 : 13),
            ),
            border: Border.all(
              color: isCardCompanyList[index]
                  ? Color(0xff3d6dc4)
                  : Colors.transparent,
              width: 0.7,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 17,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                cardCompany,
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 하단 카드 컨테이너
  Widget _cardContainer(int index, String iconPath, String cardType, String cardName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCardSelectedList[index] = !isCardSelectedList[index];
        });
      },
      child: Container(
        width: 337,
        height: 77,
        decoration: BoxDecoration(
          color: isCardSelectedList[index] ? const Color(0xffdceefd) : Colors.white,
          borderRadius: BorderRadius.circular(isCardSelectedList[index] ? 20 : 20),
          border: Border.all(
            color: isCardSelectedList[index] ? const Color(0xff3d6dc4) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: SvgPicture.asset(
                iconPath,
                width: 80,
                height: 48,
              ),
            ),
            Positioned(
              left: 120, // 원하는 위치로 조정
              top: 15, // 원하는 위치로 조정
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardType,
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff1e5094),
                    ),
                  ),
                  Text(
                    cardName,
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget StepIcon(String num, bool isCurrentStep) {
    return Container(
      width: 21,
      height: 21,
      decoration: isCurrentStep
          ? const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: [
                  Color(0xff4472fc),
                  Color(0xff8877d5),
                ],
              ),
            )
          : const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffd5d5d5),
            ),
      child: Center(
        child: Text(
          num,
          style: TextStyle(
            color: isCurrentStep ? Colors.white : const Color(0xff757575),
            fontFamily: 'Pretendard',
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget StepWidget() {
    return Row(
      children: [
        StepIcon('1', true),
        Container(
          height: 2,
          width: 12,
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
        StepIcon('2', true),
        Container(
          height: 2,
          width: 12,
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
        StepIcon('3', true),
        Container(
          height: 2,
          width: 12,
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
        StepIcon('4', true),
      ],
    );
  }

  // 상단 뒤로가기 버튼 + 스텝 표시
  Widget _stepArea(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pushNamed("/signup/3");
          },
        ),
        StepWidget()
      ],
    );
  }

  Widget _infoArea() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '연결할 카드 선택',
            style: TextStyles.TitleKorean,
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            '혜택 추천을 받고 싶은 카드를 선택해 주세요.',
            style: TextStyles.SemiTitle,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _stepArea(context),
            _infoArea(),
            SizedBox(
              height: 40,
              child: TextField(
                controller: _searchController,
                onChanged: filterCardNames,
                decoration: InputDecoration(
                  hintText: '연결하고 싶은 카드를 검색해보세요.',
                  hintStyle: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                    // size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  isCollapsed: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        _cardCompany(0,
                            "assets/images/card_logo/hyundai_logo.svg", "현대카드"),
                        _cardCompany(1,
                            "assets/images/card_logo/samsung_logo.svg", "삼성카드"),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    if (_selectedCardCompany == "현대카드")
                      Container(
                        height: 370,
                        child: SingleChildScrollView(
                          child: Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: _cardContainer(
                                    index,
                                    "assets/images/card_logo/card_example_img.svg",
                                    "신용카드",
                                    allCardNames[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    if (_selectedCardCompany == "삼성카드")
                      Container(
                        height: 370,
                        child: SingleChildScrollView(
                          child: Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: _cardContainer(
                                    index,
                                    "assets/images/card_logo/card_example_img.svg",
                                    "신용카드",
                                    allCardNames[index + 5],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
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
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    '카드 연결하기',
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
                Navigator.of(context).pushNamed("/");
              },
            ),
          ],
        ),
      ),
    );
  }
}
