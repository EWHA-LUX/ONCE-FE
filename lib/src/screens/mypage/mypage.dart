import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  final int ownedCardCount = 5;
  final int month = 8;
  final int receivedBenefit = 75000;
  final int benefitGoal = 130000;
  final String userProfileImg = "https://i.pinimg.com/originals/f1/5d/1a/f15d1a3ba005d7f28b72d3b9dee53cdd.jpg";

  Widget _gradationBody(context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          // 상단 그라데이션 베경
          height: MediaQuery.of(context).size.height / 2.0,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xff5B87FD),
                Color(0xff978EFD),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(500.0, 200.0),
              bottomRight: Radius.elliptical(500.0, 200.0),
            ),
          ),
        ),
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
        Positioned(
          top: 80,
          left: 33,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '루스 님',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '보유 카드 : $ownedCardCount장',
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 140,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '내 정보 수정하기',
                              style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 10,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("/mypage/edit");
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 38.0),
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      width: 174,
                      height: 174,
                      child: CachedNetworkImage(
                        imageUrl: userProfileImg,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 280,
          left: MediaQuery.of(context).size.width / 2 - 190,
          child: Container(
            width: 380,
            height: 165,
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
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$month월 내가 받은 혜택',
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '총 $receivedBenefit원의 할인을 받았어요.',
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xff767676)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Stack(children: [
                      LinearPercentIndicator(
                        width: 320,
                        animation: true,
                        lineHeight: 8.0,
                        animationDuration: 2000,
                        percent: receivedBenefit / benefitGoal,
                        barRadius: const Radius.circular(10.0),
                        linearGradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xff5B87FD),
                            Color(0xff978EFD),
                          ],
                        ),
                        backgroundColor: const Color(0xfff2f2f2),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Row(
                            children: const [
                              Text(
                                '월별 혜택 더보기',
                                style: TextStyle(
                                    fontFamily: 'Pretendard',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff767676)),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 10,
                                color: Color(0xff767676),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed("/mypage/benefit");
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
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

  Widget _mypageMenu(context, String iconPath, String title, String description,
      String routeName) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 55),
      child: GestureDetector(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 70,
            ),
            const SizedBox(
              width: 45,
            ),
            Column(
              children: [
                Text(
                  description,
                  style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737373)),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                )
              ],
            )
          ],
        ),
        onTap: () {
          Navigator.of(context).pushNamed(routeName);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        children: [
          _gradationBody(context),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _mypageMenu(context, "assets/images/3d_icons/chat_3d_icon.svg",
                  "원스와의 대화", "결제 전 나의 모든 검색 내역", "/mypage/chat-history"),
              _mypageMenu(context, "assets/images/3d_icons/setting_3d_icon.svg",
                  "주카드 관리", "내가 가진 카드 관리하기", "/mypage/maincard-manage"),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '회원 탈퇴하기',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff767676)),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: Color(0xff767676),
                      ),
                      onTap: () {
                        // 회원 탈퇴 api
                      },
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
