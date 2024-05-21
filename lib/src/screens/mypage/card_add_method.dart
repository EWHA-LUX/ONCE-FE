import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class CardAddMethod extends StatefulWidget {
  const CardAddMethod({super.key});

  @override
  State<CardAddMethod> createState() => _CardAddMethodState();
}

class _CardAddMethodState extends State<CardAddMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: EmptyAppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Center(
                child: Container(
                    width: 350,
                    height: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Image.asset(
                            'assets/images/3d_icons/search_3d_icon.png',
                            width: 70,
                            height: 70,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '카드 추가하기',
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '검색으로 새로운 카드 등록',
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Color(0xff7676767)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Image.asset(
                            'assets/images/icons/next_icon.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    )),
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/mypage/maincard-manage/add/1");
              },
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Center(
                child: Container(
                    width: 350,
                    height: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SvgPicture.asset(
                              "assets/images/3d_icons/menu_3d_icon.svg",
                              width: 70,
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '카드사 연결하기',
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '카드 관리 원스에서 한 번에',
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Color(0xff7676767)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Image.asset(
                            'assets/images/icons/next_icon.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    )),
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/codef");
              },
            )
          ],
        ));
  }
}
