import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5F0FF),
      appBar: EmptyAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          SvgPicture.asset(
            'assets/images/once_logo/once_logo_white.svg',
            width: 140,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            '모든 카드 혜택을 한눈에',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          const SpinKitFadingFour(
            color: Color(0xff0083EE),
            size: 50.0,
            duration: Duration(seconds: 1),
          ),
        ],
      ),
    );
  }
}
