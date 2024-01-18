import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

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

  Widget _today() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Today',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget _lastWeek() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Last Week',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w700),
          )
        ],
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
        children: [_title(context), _today(), _lastWeek()],
      ),
    );
  }
}
