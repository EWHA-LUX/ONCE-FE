import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum NoticeType { TYPE1, TYPE2, TYPE3, TYPE4 }

class NoticeWidget extends StatelessWidget {
  bool hasCheck;
  String content;
  String announceDate;
  NoticeType type;

  NoticeWidget(
      {Key? key,
      required this.type,
      required this.hasCheck,
      required this.content,
      required this.announceDate})
      : super(key: key);

  Widget type1Widget() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/3d_icons/one_coin_3d_icon.svg',
          width: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 260,
                    child: Text(
                      content,
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15,
                          fontWeight:
                              hasCheck ? FontWeight.w500 : FontWeight.w800),
                      overflow: TextOverflow.ellipsis, // Add this line
                    ),
                  ),
                  hasCheck
                      ? const SizedBox(
                          width: 0,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: 5.0,
                            height: 5.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffFF3838), // 점의 색상
                            ),
                          ),
                        )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                    '결제 카드 추천',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff366FFF)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    announceDate,
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff767676)),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget type2Widget() {
    return Row(
      children: [
        Image.asset(
          'assets/images/3d_icons/goal_3d_icon.png',
          width: 50,
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 260,
                    child: Text(
                      content,
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15,
                          fontWeight:
                              hasCheck ? FontWeight.w500 : FontWeight.w800),
                      overflow: TextOverflow.ellipsis, // Add this line
                    ),
                  ),
                  hasCheck
                      ? const SizedBox(
                          width: 0,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: 5.0,
                            height: 5.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffFF3838), // 점의 색상
                            ),
                          ),
                        )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                    '목표 응원 알림',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff366FFF)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    announceDate,
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff767676)),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget type3Widget() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/3d_icons/notice_3d_icon.svg',
          width: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 260,
                    child: Text(
                      content,
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15,
                          fontWeight:
                              hasCheck ? FontWeight.w500 : FontWeight.w800),
                      overflow: TextOverflow.ellipsis, // Add this line
                    ),
                  ),
                  hasCheck
                      ? const SizedBox(
                          width: 0,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: 5.0,
                            height: 5.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffFF3838), // 점의 색상
                            ),
                          ),
                        )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                    '원스 공지 알림',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff366FFF)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    announceDate,
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff767676)),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget type4Widget() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/3d_icons/card_3d_icon.svg',
          width: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 260,
                    child: Text(
                      content,
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15,
                          fontWeight:
                              hasCheck ? FontWeight.w500 : FontWeight.w800),
                      overflow: TextOverflow.ellipsis, // Add this line
                    ),
                  ),
                  hasCheck
                      ? const SizedBox(
                          width: 0,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: 5.0,
                            height: 5.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffFF3838), // 점의 색상
                            ),
                          ),
                        )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                    '카드 실적 알림',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff366FFF)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    announceDate,
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff767676)),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      // type에 따라 다른 위젯
      case NoticeType.TYPE1:
        return type1Widget();
      case NoticeType.TYPE2:
        return type2Widget();
      case NoticeType.TYPE3:
        return type3Widget();
      case NoticeType.TYPE4:
        return type4Widget();
    }
    ;
  }
}
