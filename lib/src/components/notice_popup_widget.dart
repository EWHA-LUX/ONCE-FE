import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

enum NoticePopupType { TYPE1, TYPE2, TYPE3, TYPE4 }

class NoticePopupWidget extends StatefulWidget {
  NoticePopupType type;
  String content;
  String moreInfo;
  String announceDate;

  NoticePopupWidget(
      {Key? key,
      required this.type,
      required this.content,
      required this.moreInfo,
      required this.announceDate})
      : super(key: key);

  @override
  State<NoticePopupWidget> createState() => _NoticePopupWidgetState();
}

class _NoticePopupWidgetState extends State<NoticePopupWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  // type 1 - 결제 카드 추천
  Widget popup1Widget() {
    // 문자열 좌표로 변환
    List<String> coordinates = widget.moreInfo.split(', ');
    double latitude = double.parse(coordinates[0]);
    double longitude = double.parse(coordinates[1]);

    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xff767676),
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '결제 카드 추천',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.announceDate,
                      style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff767676)),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 60,
                ),
                SvgPicture.asset(
                  'assets/images/3d_icons/one_coin_3d_icon.svg',
                  width: 50,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude, longitude), // 지도 위치
                        zoom: 18,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // type 2 - 목표 응원 알림
  Widget popup2Widget() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xff767676),
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '목표 응원 알림',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.announceDate,
                      style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff767676)),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 60,
                ),
                Image.asset(
                  'assets/images/3d_icons/goal_3d_icon.png',
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ),
          Center(
              child: Container(
                  width: 265,
                  height: 190,
                  decoration: const BoxDecoration(
                    color: Color(0xffF4F4F4),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(children: [
                            CircularPercentIndicator(
                                radius: 50.0,
                                animation: true,
                                animationDuration: 2000,
                                lineWidth: 8.0,
                                percent: (double.parse(widget.moreInfo)) / 100,
                                center: Text(
                                  '${widget.moreInfo}%',
                                  style: const TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff767676)),
                                ),
                                linearGradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Color(0xff5B87FD),
                                    Color(0xff978EFD),
                                  ],
                                ),
                                backgroundColor: Colors.white)
                          ]),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            widget.content,
                            style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  // type 3 - 원스 공지 알림
  Widget popup3Widget() {
    String noticeContent = widget.content.replaceAll(r'\n', "\n");
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xff767676),
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '원스 공지 알림',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.announceDate,
                      style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff767676)),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 60,
                ),
                SvgPicture.asset(
                  'assets/images/3d_icons/notice_3d_icon.svg',
                  width: 50,
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 265,
              height: 190,
              decoration: const BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    noticeContent,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 35.0,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xff5B87FD),
                            Color(0xff978EFD),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: const Text('업데이트 하러가기'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // type 4 - 카드 실적 알림
  Widget popup4Widget() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xff767676),
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '카드 실적 알림',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.announceDate,
                      style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff767676)),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 60,
                ),
                SvgPicture.asset(
                  'assets/images/3d_icons/card_3d_icon.svg',
                  width: 50,
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 265,
              height: 190,
              decoration: const BoxDecoration(
                color: Color(0xffF4F4F4),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.moreInfo,
                    width: 65,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      widget.content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      // type에 따라 다른 위젯
      case NoticePopupType.TYPE1:
        return popup1Widget();
      case NoticePopupType.TYPE2:
        return popup2Widget();
      case NoticePopupType.TYPE3:
        return popup3Widget();
      case NoticePopupType.TYPE4:
        return popup4Widget();
    }
  }
}
