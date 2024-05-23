import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  late List<dynamic> _cardCompnayList = [];
  late List<dynamic> _cardList = [];
  late List<dynamic> _selectedCompanyCards = [];
  int _selectedCardCompanyIndex = 0;

  late List<int> selectedCardList = [];

  _Signup4State() {
    isCardCompanyList[0] = true;
    _filteredCompanyCards = _selectedCompanyCards;
  }

  @override
  void initState() {
    super.initState();
    selectedCardIndex = []; // 선택된 카드 인덱스 초기화
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      selectedCardIndex =
          ModalRoute.of(context)!.settings.arguments as List<int>;
      _getCardDetails(context, selectedCardIndex);
    });
  }

  List<bool> isCardSelectedList = List.generate(6, (index) => false);
  List<bool> isCardCompanyList = List.generate(6, (index) => false);
  List<String> filteredCardNames = [];

  TextEditingController _searchController = TextEditingController();
  String _selectedCardCompany = "";

  // [Get] 카드사로 카드 검색
  void _getCardDetails(
      BuildContext context, List<int> selectedCardIndex) async {
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

    final baseOptions = BaseOptions();

    final dio = Dio(baseOptions);

    try {
      String queryString = 'code=' + cardCodes.join(',');
      String apiUrlWithQuery = apiUrl + '?' + queryString;

      var response = await dio.get(apiUrlWithQuery);
      Map<dynamic, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        final List<dynamic> cardDetails = responseData['result'];

        _selectedCompanyCards.clear();

        for (var cardDetail in cardDetails) {
          _cardCompnayList.add(cardDetail['companyName']);
          _cardList.add(cardDetail['cardList']);
          _selectedCompanyCards.addAll(cardDetail['cardList']);
        }
        _selectedCardCompany = _cardCompnayList[0];
        print(_cardCompnayList);
        print(_cardList);
        print(_selectedCardCompany);

        setState(() {});
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

  // [Get] 카드 이름 검색
  void _getCardSearch(BuildContext context, List<int> selectedCardIndex,
      String searchName) async {
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

    final String apiUrl = '$BASE_URL/user/card/searchname';

    final baseOptions = BaseOptions();

    final dio = Dio(baseOptions);

    try {
      String queryString = 'code=' + cardCodes.join(',') + '&name=$searchName';
      String apiUrlWithQuery = apiUrl + '?' + queryString;

      var response = await dio.get(apiUrlWithQuery);
      Map<dynamic, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        final List<dynamic> cardDetails = responseData['result'];
        _cardList = cardDetails;

        // 기존 카드사 탭 모두 선택 해제
        setState(() {
          _selectedCardCompanyIndex = -1;
          isCardCompanyList =
              List.generate(_cardCompnayList.length, (index) => false);
          _filteredCompanyCards = cardDetails;
        });

        // 기존의 카드 리스트 제거
        _selectedCompanyCards.clear();

        if (cardDetails.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("검색 결과가 없음"),
                content: Text("검색 결과가 없습니다."),
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

  // [Post] 기기 토큰 등록
  Future<void> sendTokenToServer(String token) async {
    final String BASE_URL = Constants.baseUrl;
    final String apiUrl = '$BASE_URL/user/token';

    const storage = FlutterSecureStorage();
    String? storedAccessToken = await storage.read(key: 'accessToken');

    if (storedAccessToken != null) {
      final baseOptions = BaseOptions(
        headers: {'Authorization': 'Bearer $storedAccessToken'},
      );

      final dio = Dio(baseOptions);

      try {
        var response =
        await dio.post(apiUrl, data: {"token": token});
        Map<dynamic, dynamic> responseData = response.data;
        print(responseData);
      } catch (e) {
        print('토큰 전송 오류: $e');
      }
    } else {
      print('AccessToken 없음');
    }
  }

  // [Post] 카드 등록
  void _postSelectedCards(
      BuildContext context, List<int> selectedCardList) async {
    final String apiUrl = '$BASE_URL/user/card';
    final Map<String, dynamic> requestData = {
      "cardList": selectedCardList,
    };

    const storage = FlutterSecureStorage();
    String? storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      final response = await dio.post(apiUrl, data: requestData);
      final responseData = response.data;
      print(responseData);
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

  String _getIconPathForCompany(String companyName) {
    switch (companyName) {
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

            _filteredCompanyCards = _cardList[index];
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
  Widget _cardContainer(
      int cardId, String cardImg, String cardName, String type) {
    bool isSelected = selectedCardList.contains(cardId);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedCardList.remove(cardId);
          } else {
            selectedCardList.add(cardId);
          }
        });
      },
      child: Container(
        width: 337,
        height: 77,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffdceefd) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xff3d6dc4) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _selectedCardCompany == '현대카드' ||
                      _selectedCardCompany == '삼성카드'
                  ? Transform.rotate(
                      angle: 3.1415926535897932 / 2,
                      child: Image.network(
                        cardImg,
                        width: 58,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Image.network(
                      cardImg,
                      width: 58,
                      fit: BoxFit.contain,
                    ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  type,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0083EE),
                  ),
                ),
                const SizedBox(
                  height: 3,
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

  List<dynamic> _filteredCompanyCards = [];

  void filterCardNames(String query) {
    setState(() {
      _filteredCompanyCards = _selectedCompanyCards
          .where((card) =>
              card['cardName'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildCardCompanyList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // 가로 스크롤
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _cardCompnayList.map((companyName) {
          return _cardCompany(
            _cardCompnayList.indexOf(companyName),
            _getIconPathForCompany(companyName),
            companyName,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCardList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredCompanyCards.length,
      itemBuilder: (context, index) {
        final card = _filteredCompanyCards[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _cardContainer(
              card['cardId'], card['cardImg'], card['cardName'], card['type']),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _getCardSearch(
                            context, selectedCardIndex, _searchController.text);
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
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
              _buildCardCompanyList(),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 370,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCardList(),
                    ],
                  ),
                ),
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
                onTap: () async {
                  _postSelectedCards(context, selectedCardList);

                  WidgetsFlutterBinding.ensureInitialized();
                  await Firebase.initializeApp(); // Firebase 초기화
                  final token = await FirebaseMessaging.instance.getToken();
                  if (token != null) {
                    print("FCM Token: $token");
                    await sendTokenToServer(token); // 서버에 토큰 전송
                  } else {
                    print("FCM Token이 null입니다.");
                  }

                  Navigator.of(context).pushNamed("/");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
