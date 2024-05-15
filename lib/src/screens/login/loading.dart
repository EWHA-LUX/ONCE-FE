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
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitFadingFour(
                color: Color(0xff0083EE),
                size: 60.0,
                duration: Duration(seconds: 1),
              ),
              SizedBox(height: 20,),
              Text(
                'LOADING',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffffffff)),
              ),
            ],
          ),
      ),
    );
  }
}
