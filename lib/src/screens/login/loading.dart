import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/background/gradation_background.svg',
              fit: BoxFit.cover,
            ),
            Center(
              child: Positioned(
                top: -30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/once_logo/once_logo_white.svg',
                      width: 140,
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'ONCE',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.white,
                      ),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}