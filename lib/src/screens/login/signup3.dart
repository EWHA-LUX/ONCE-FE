import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/style.dart';

class Signup3 extends StatefulWidget {
  const Signup3({Key? key}) : super(key: key);

  @override
  _Signup3State createState() => _Signup3State();
}

class _Signup3State extends State<Signup3> {
  List<bool> isCardSelectedList = List.generate(6, (index) => false);
  bool isAllSelected = false;

  List<int> selectedCards() {
    List<int> selectedCardNames = [];
    for (int i = 0; i < isCardSelectedList.length; i++) {
      if (isCardSelectedList[i]) {
        selectedCardNames.add(i);
      }
    }
    return selectedCardNames;
  }

  Widget _cardContainer(int index, String cardName, String iconPath) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isAllSelected) {
            isAllSelected = !isAllSelected;
            isCardSelectedList[index] = !isCardSelectedList[index];
          } else {
            isCardSelectedList[index] = !isCardSelectedList[index];
          }

        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: isCardSelectedList[index] || isAllSelected
                  ? const Color(0xffdceefd)
                  : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(isCardSelectedList[index] || isAllSelected
                    ? 20
                    : 20), // Apply borderRadius based on selection state
              ),
              border: Border.all(
                color: isCardSelectedList[index] || isAllSelected
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
          color: const Color(0xffd5d5d5),
        ),
        StepIcon('4', false),
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
            Navigator.of(context).pushNamed("/signup/2");
          },
        ),
        StepWidget()
      ],
    );
  }

  Widget _infoArea() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 10.0, bottom: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '카드 등록',
            style: TextStyles.TitleKorean,
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            '혜택을 받고 싶은 카드사를 선택해 주세요.',
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _stepArea(context),
            _infoArea(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAllSelected = !isAllSelected;
                      if (isAllSelected) {
                        isCardSelectedList =
                            List.generate(6, (index) => isAllSelected);
                      } else {
                        for (int i = 0; i < isCardSelectedList.length; i++) {
                          isCardSelectedList[i] = !isCardSelectedList[i];
                        }
                      }
                    });
                  },
                  child: SvgPicture.asset(
                    isAllSelected
                        ? "assets/images/icons/card_check_icon.svg"
                        : "assets/images/icons/card_uncheck_icon.svg",
                    width: 18,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    '전체 카드사 선택',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
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
                    '카드 검색',
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
                Navigator.of(context).pushNamed(
                  "/signup/4",
                  arguments: selectedCards(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
