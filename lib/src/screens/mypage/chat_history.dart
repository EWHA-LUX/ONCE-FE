import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({super.key});

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
  }

  void goToNextMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
    });
  }

  void goToPreviousMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month - 1);
    });
  }

  Widget _gradationBody(context, String formattedDate) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          // 상단 그라데이션 베경
          height: 200,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          '원스와의 대화',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                              color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        child: SvgPicture.asset(
                          'assets/images/icons/alarm_icon.svg',
                          width: 28,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("/notification");
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                const Text(
                  '원스 챗봇과 나누었던 과거 카드 추천 기록을 확인해 보세요.',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xffe8e8e8)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 170,
          left: MediaQuery.of(context).size.width / 2 - 170,
          child: Container(
            width: 340,
            height: 55,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.3,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 12,
                    color: Colors.black,
                  ),
                  onTap: () {
                    goToPreviousMonth();
                  },
                ),
                Text('${formattedDate}',
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: Colors.black,
                  ),
                  onTap: () {
                    goToNextMonth();
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _chatList(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45.0, left: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:  [
          const Text(
            '대화 목록',
            style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 330,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),

              ),

            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy년 MM월').format(currentDate);

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        children: [_gradationBody(context, formattedDate), _chatList(context)],
      ),
    );
  }
}
