import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/style.dart';

class Signup4 extends StatefulWidget {
  const Signup4({Key? key}) : super(key: key);

  @override
  _Signup4State createState() => _Signup4State();
}

class _Signup4State extends State<Signup4> {

  List<bool> isCardSelectedList = List.generate(6, (index) => false);
  List<bool> isCardCompanyList = List.generate(2, (index) => false);
  List<String> filteredCardNames = [];

  TextEditingController _searchController = TextEditingController();

  List<String> allCardNames = [
    '현대카드 M Boost',
    '현대카드 ZERO Edition2',
    '현대카드M Edition3',
    '우리동네 GS 삼성카드',
    '국만행복 삼성체크카드 v2',
    '롯데카드 M Boost',
    '롯데카드 ZERO Edition2',
    '롯데카드M Edition3',
    '롯데카드 GS 삼성카드',
    '롯데카드 삼성체크카드 v2',
    // Add other card names
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
    return InkWell(
      onTap: () {
        setState(() {
          isCardCompanyList[index] = !isCardCompanyList[index];
        });
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              width: 93,
              height: 31,
              decoration: BoxDecoration(
                color: isCardSelectedList[index] ? const Color(0xffdceefd) : Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(isCardSelectedList[index] ? 13 : 13), // Apply borderRadius based on selection state
                ),
                border: Border.all(
                  color: isCardSelectedList[index] ? Color(0xff3d6dc4) : Colors.transparent,
                  width: 0.7,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 5),
                child: SvgPicture.asset(
                  iconPath,
                  width: 17,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 5),
                child: Text(
                  cardCompany,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 하단 카드 컨테이너
  Widget _cardContainer(int index, String iconPath, String cardType, String cardName) {
    return InkWell(
      onTap: () {
        setState(() {
          isCardSelectedList[index] = !isCardSelectedList[index];
        });
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              width: 337,
              height: 77,
              decoration: BoxDecoration(
                color: isCardSelectedList[index] ? const Color(0xffdceefd) : Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(isCardSelectedList[index] ? 20 : 20), // Apply borderRadius based on selection state
                ),
                border: Border.all(
                  color: isCardSelectedList[index] ? Color(0xff3d6dc4) : Colors.transparent,
                  width: 1,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: SvgPicture.asset(
                  iconPath,
                  width: 80,
                  height: 48,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 15),
                    child: Text(
                      cardType,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff1e5094),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 5),
                    child: Text(
                      cardName,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
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
            Container(
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
                          Navigator.of(context).pushNamed("/signup/3");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '연결 카드 선택',
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
                      '혜택 추천을 받고 싶은 카드를 선택해주세요.',
                      style: TextStyles.SemiTitle,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 337,
                      height: 38,
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
                          ),
                          filled: true,
                          fillColor: Colors.white,
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
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            _cardCompany(0, "assets/images/card_logo/hyundai_logo.svg", "현대카드"),
                            _cardCompany(1, "assets/images/card_logo/samsung_logo.svg", "삼성카드"),
                            _cardCompany(2, "assets/images/card_logo/lotte_logo.svg", "롯데카드"),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: [
                            _cardContainer(0, "assets/images/card_logo/card_example_img.svg", "신용카드", allCardNames[0]),
                            const SizedBox(height: 10),
                            _cardContainer(1, "assets/images/card_logo/card_example_img.svg", "신용카드", allCardNames[1]),
                            const SizedBox(height: 10),
                            _cardContainer(2, "assets/images/card_logo/card_example_img.svg", "신용카드", allCardNames[2]),
                            const SizedBox(height: 10),
                            _cardContainer(3, "assets/images/card_logo/card_example_img.svg", "체크카드", allCardNames[3]),
                            const SizedBox(height: 10),
                            _cardContainer(4, "assets/images/card_logo/card_example_img.svg", "체크카드", allCardNames[4]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
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
            ),
          ],
        ),
      ),
    );
  }
}
