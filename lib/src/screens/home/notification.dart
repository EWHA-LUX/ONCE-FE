import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/src/components/notice_widget.dart';

class PushNotification extends StatelessWidget {
  const PushNotification({super.key});

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
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text.rich(TextSpan(children: <TextSpan>[
            TextSpan(
              text: '루스 님에게',
              style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff767676)),
            ),
            TextSpan(
              text: ' 3개의 새로운 알림',
              style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff366FFF)),
            ),
            TextSpan(
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
          NoticeWidget(
            type: NoticeType.TYPE1,
            content: "이대역 스타벅스 근처이시군요. 현대 M 카드 사용해 보세요.",
            announceDate: "11/18/2023 19:35:45",
            hasCheck: false,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Divider(
              color: Color(0xff767676), // 가로줄의 색상
            ),
          ),
          NoticeWidget(
            type: NoticeType.TYPE1,
            content: "다이소 신촌본점이시군요. 신한 플래티넘 카드를 사용해 보세요.",
            announceDate: "11/18/2023 12:27:58",
            hasCheck: false,
          )
        ],
      ),
    );
  }

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
          NoticeWidget(
            type: NoticeType.TYPE2,
            content: "11월 목표 혜택 달성까지 7,000원 남았어요.",
            announceDate: "11/15/2023 09:00:00",
            hasCheck: false,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Divider(
              color: Color(0xff767676), // 가로줄의 색상
            ),
          ),
          NoticeWidget(
            type: NoticeType.TYPE2,
            content: "11월 목표 혜택 달성까지 7,000원 남았어요.",
            announceDate: "11/08/2023 09:00:00",
            hasCheck: true,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Divider(
              color: Color(0xff767676), // 가로줄의 색상
            ),
          ),
          NoticeWidget(
            type: NoticeType.TYPE1,
            content: "GS25 신촌 이화점 근처이시군요. 신한 플래티넘 카드를 사용해 보세요.",
            announceDate: "11/05/2023 11:26:18",
            hasCheck: true,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Divider(
              color: Color(0xff767676), // 가로줄의 색상
            ),
          ),
          NoticeWidget(
            type: NoticeType.TYPE3,
            content: "9월 16일 원스가 업데이트 되었어요. 확인해 보세요.",
            announceDate: "9/16/2023 9:00:00",
            hasCheck: true,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Divider(
              color: Color(0xff767676), // 가로줄의 색상
            ),
          ),
          NoticeWidget(
            type: NoticeType.TYPE4,
            content: "이번 달 현대 M카드 실적까지 35,000원 남았어요.",
            announceDate: "9/15/2023 11:56:20",
            hasCheck: true,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Divider(
              color: Color(0xff767676), // 가로줄의 색상
            ),
          ),
          NoticeWidget(
            type: NoticeType.TYPE1,
            content: "신촌역 스타벅스 근처이시군요. 신한 플래티넘 카드를 사용해 보세요.",
            announceDate: "9/12/2023 17:26:38",
            hasCheck: true,
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_title(context), _notificationArea(context)],
      ),
    );
  }
}
