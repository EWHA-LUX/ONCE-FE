import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:once_front/constants.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/src/components/notice_popup_widget.dart';
import 'package:once_front/src/components/notice_widget.dart';
import 'package:once_front/src/screens/login/loading.dart';

class PushNotification extends StatefulWidget {
  const PushNotification({super.key});

  @override
  State<PushNotification> createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  final String BASE_URL = Constants.baseUrl;

  String nickname = '';
  int announceCount = 0;
  List<dynamic> announceTodayList = [];
  List<dynamic> announcePastList = [];

  late Future<void> _noticeListFuture;

  @override
  void initState() {
    super.initState();
    _noticeListFuture = _noticeList();
  }

  void _updateState(Map<dynamic, dynamic> responseData) {
    setState(() {
      nickname = responseData['result']['nickname'];
      announceCount = responseData['result']['announceCount'];
      announceTodayList = responseData['result']['announceTodayList'];
      announcePastList = responseData['result']['announcePastList'];
    });
  }

  // [Get] 알림 리스트 조회
  Future<void> _noticeList() async {
    // ==================== API 통신 ====================
    final String apiUrl = '${BASE_URL}/home/announcement';

    const storage = FlutterSecureStorage();
    String? storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      var response = await dio.get(apiUrl);
      Map<dynamic, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        _updateState(responseData);
      }
    } catch (e) {
      // ** 차후 수정 필요 **
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

  Widget _title(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0, right: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                child: const Icon(
                  Icons.close,
                  size: 25,
                  color: Color(0xff727272),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        const Text(
          '나의 알림',
          style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 23,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text.rich(TextSpan(children: <TextSpan>[
            TextSpan(
              text: '$nickname 님에게',
              style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff767676)),
            ),
            TextSpan(
              text: ' $announceCount개의 새로운 알림',
              style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff366FFF)),
            ),
            const TextSpan(
              text: '이 도착했습니다.',
              style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff767676)),
            ),
          ])),
        )
      ],
    );
  }

  // 팝업 띄우기
  void showPopup(context, noticePopupType, content, moreInfo, announceDate) {
    showDialog(
        context: context,
        barrierDismissible: false, // 팝업 밖에는 안 눌리게
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 430,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: NoticePopupWidget(
                    type: noticePopupType,
                    content: content,
                    moreInfo: moreInfo,
                    announceDate: announceDate)),
          );
        });
  }

  NoticeType _mapType(int type) {
    switch (type) {
      case 0:
        return NoticeType.TYPE1;
      case 1:
        return NoticeType.TYPE2;
      case 2:
        return NoticeType.TYPE3;
      case 3:
        return NoticeType.TYPE4;
      default:
        return NoticeType.TYPE1;
    }
  }

  // 오늘 알림 리스트
  Widget _today(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Today',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Column(
            children: List.generate(announceTodayList.length * 2 - 1, (index) {
              if (index % 2 == 0) {
                final noticeIndex = index ~/ 2;
                final announcement = announceTodayList[noticeIndex];
                return NoticeWidget(
                  type: _mapType(announcement['type']),
                  content: announcement['content'],
                  announceDate: announcement['announceDate'],
                  hasCheck: announcement['hasCheck'],
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Divider(
                    color: Color(0xff767676),
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }

  // 지난 주 알림 리스트
  Widget _lastWeek(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Last Week',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Column(
            children: List.generate(announcePastList.length * 2 - 1, (index) {
              if (index % 2 == 0) {
                final noticeIndex = index ~/ 2;
                final announcement = announcePastList[noticeIndex];
                return NoticeWidget(
                  type: _mapType(announcement['type']),
                  content: announcement['content'],
                  announceDate: announcement['announceDate'],
                  hasCheck: announcement['hasCheck'],
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Divider(
                    color: Color(0xff767676),
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }

  Widget _notificationArea(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [_today(context), _lastWeek(context)],
        ),
      ),
    );
  }

  Widget notificationUI(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_title(context), _notificationArea(context)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _noticeListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // 데이터가 로드된 후에 표시할 화면
          return notificationUI(context);
        }
      },
    );
  }
}
