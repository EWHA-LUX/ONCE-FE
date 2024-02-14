import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Widget _backButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 25.0),
      child: Row(
        children: [
          GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Widget _appSetting() {

    return Padding(
      padding: const EdgeInsets.only(top: 42.0),
      child: Container(
        width: 340,
        height: 100,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.4,
                blurRadius: 3,
                offset: Offset(0, 1),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 10.0),
              child: Text(
                '앱 설정',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  const Text(
                    '화면 모드 설정',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                  Switch(value: false , onChanged: (bool value) {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _serviceInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: 340,
        height: 160,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.4,
                blurRadius: 3,
                offset: Offset(0, 1),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                '이용 안내',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '앱 버전',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                  Text(
                    '1.0.2 (20240301)',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xff767676)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                '서비스 이용약관',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                '개인정보 처리 방침',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _extraSetting() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: 340,
        height: 140,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.4,
                blurRadius: 3,
                offset: Offset(0, 1),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                '기타',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '로그아웃',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '회원 탈퇴',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        children: [
          _backButton(),
          _appSetting(),
          _serviceInfo(),
          _extraSetting()
        ],
      ),
    );
  }
}
