import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

import 'chat_item.dart';

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
                Color(0xff4472fc),
                Color(0xff8877d5),
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
                Text(formattedDate,
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
    Map<String, List<ChatItem>> groupedData = {};

    // chatData로 그룹화
    for (ChatItem chatItem in chatDataList) {
      if (!groupedData.containsKey(chatItem.chatDate)) {
        groupedData[chatItem.chatDate] = [];
      }
      groupedData[chatItem.chatDate]!.add(chatItem);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 45.0, left: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '대화 목록',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var entry in groupedData.entries)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 23.0, vertical: 20.0),
                            child: Row(
                              children: [
                                Text(
                                  entry.key, // chatDate
                                  style: const TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff767676)),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: Color(0xff767676),
                                    thickness: 1.5,
                                    indent: 20,
                                    endIndent: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: entry.value.length,
                            itemBuilder: (context, index) {
                              ChatItem chatItem = entry.value[index];
                              return ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            chatItem.keyword,
                                            style: const TextStyle(
                                              fontFamily: 'Pretendard',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            chatItem.cardName,
                                            style: const TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff0083EE)),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        chatItem.chatTime,
                                        style: const TextStyle(
                                            fontFamily: 'Pretendard',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff767676)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _gradationBody(context, formattedDate),
            _chatList(context)
          ],
        ),
      ),
    );
  }
}
