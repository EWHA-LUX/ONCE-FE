import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class RegisterMainCard extends StatefulWidget {
  const RegisterMainCard({Key? key}) : super(key: key);

  @override
  _RegisterMainCardState createState() => _RegisterMainCardState();
}

class _RegisterMainCardState extends State<RegisterMainCard> {
  bool isChecked = false;
  bool isSecondChecked = false;
  bool isThirdChecked = false;

  bool get allChecked => isChecked && isSecondChecked && isThirdChecked;

  void updateAllChecked() {
    setState(() {
      isChecked = isSecondChecked && isThirdChecked;
    });
  }

  @override
  Widget _termsArea(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 2 - 290,
      ),
      child: Center(
        child: Container(
          width: 335,
          height: 480,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.3,
                blurRadius: 2,
                offset: Offset(0, 1),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 26, top: 26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/icons/codef_icon.svg',
                          width: 78,
                          height: 34,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'CODEF API',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 3,),
                            Text(
                              'Hecto Data',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFFADADAD),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                              isSecondChecked = isChecked;
                              isThirdChecked = isChecked;
                            });
                          },
                          child: SvgPicture.asset(
                            'assets/images/icons/terms_check_icon.svg',
                            width: 25,
                            height: 25,
                            color: isChecked ? const Color(0xFF0083EE) : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateAllChecked();
                              },
                              child: Text(
                                '전체 동의하기',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isChecked ? const Color(0xFF0083EE) : null,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              '전체동의는 선택목적에 대한 동의를 포함하고',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFFADADAD),
                              ),
                            ),
                            const SizedBox(height: 3),
                            const Text(
                                  '있으며, 선택목적에 대한 동의를 거부해도 서비스',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFFADADAD),
                              ),
                            ),
                            const SizedBox(height: 3),
                            const Text(
                                  '이용이 가능합니다.',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFFADADAD),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSecondChecked = !isSecondChecked;
                            });
                          },
                          child: SvgPicture.asset(
                            'assets/images/icons/terms_check_icon_single.svg',
                            width: 22,
                            height: 22,
                            color: isSecondChecked
                                ? const Color(0xFF0083EE)
                                : const Color(0xFFADADAD),
                          ),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Container(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSecondChecked = !isSecondChecked;
                                    updateAllChecked();
                                  });
                                },
                                child: Text(
                                  '동의합니다.',
                                  style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: isSecondChecked
                                        ? const Color(0xFF0083EE)
                                        : const Color(0xFFADADAD),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '원스 서비스는 민감한 개인정보를 수집하고 안전하'
                                    '게 보호하기 위해 최선의 노력을 기울이고 있습니'
                                    '다. 카드사 연결을 위해서는 다음의 내용에 동의해'
                                    '야 합니다.',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFFADADAD),
                                  height: 1.5
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 15, left: 5),
                        child: SvgPicture.asset(
                          'assets/images/3d_icons/security_3d_icon.svg',
                          width: 51,
                          height: 51,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 26),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isThirdChecked = !isThirdChecked;
                              updateAllChecked();
                            });
                          },
                          child: SvgPicture.asset(
                            'assets/images/icons/terms_check_icon_single.svg',
                            width: 22,
                            height: 22,
                            color: isThirdChecked
                                ? const Color(0xFF0083EE)
                                : const Color(0xFFADADAD),
                          ),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isThirdChecked = !isThirdChecked;
                                });
                              },
                              child: Text(
                                '동의합니다.',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isThirdChecked
                                      ? const Color(0xFF0083EE)
                                      : const Color(0xFFADADAD),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '[필수] 원스 서비스 이용약관',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFFADADAD),
                              ),
                            ),
                            const SizedBox(height: 4,),
                            const Text(
                                  '[필수] 개인정보 수집 및 이용 동의',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFFADADAD),
                              ),
                            ),
                            const SizedBox(height: 4,),
                            const Text(
                                  '[필수] 개인정보 제3자 제공 동의',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFFADADAD),
                              ),
                            ),
                            const SizedBox(height: 4,),
                            const Text(
                                  '[필수] 개인정보 제3자 제공 동의 (카드사)',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFFADADAD),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
              ElevatedButton(
                onPressed: allChecked
                    ? () {
                  Navigator.of(context).pushNamed("/codef/2");
                }
                    : null, // 모든 동의 항목이 체크되어야 버튼이 활성화
                child: Text(
                  '동의하고 계속하기',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: allChecked ? Colors.white : Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color(0xFFE5E5E5); // 비활성화
                      }
                      return const Color(0xFF0083EE); // 활성화
                    },
                  ),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      );
                    },
                  ),
                  minimumSize: MaterialStateProperty.all(Size.fromHeight(53)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff666666),
      appBar: EmptyAppBar(),
      body: Column(
        children: [
          _termsArea(context),
          const SizedBox(height: 15),
          GestureDetector(
            child: const Text(
              '취소',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.underline,
                color: Color(0xffADADAD),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/mypage/maincard-manage");
            },
          ),
        ],
      ),
    );
  }
}
