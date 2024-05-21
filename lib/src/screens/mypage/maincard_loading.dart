import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainCardLoading extends StatelessWidget {
  final String code;

  const MainCardLoading({Key? key, required this.code}) : super(key: key);

  String _getIconPathCradLogo(String code) {
    switch (code) {
      case "0306":
        return "assets/images/card_logo/shinhan_logo.svg";
      case "0302":
        return "assets/images/card_logo/hyundai_logo.svg";
      case "0301":
        return "assets/images/card_logo/kookmin_logo.svg";
      case "0303":
        return "assets/images/card_logo/samsung_logo.svg";
      case "0311":
        return "assets/images/card_logo/lotte_logo.svg";
      case "0313":
        return "assets/images/card_logo/hana_logo.svg";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    String iconPath = _getIconPathCradLogo(code);
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: EmptyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath.isNotEmpty)
              SvgPicture.asset(
                iconPath,
                width: 105,
              )
            else
              Container(),
            SizedBox(height: 30),
            SpinKitThreeBounce(
              color: Color(0xff0083EE),
              size: 20.0,
            ),
            SizedBox(height: 30),
            Text(
              '안전하게 연결 중이에요.',
              style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff939393)),
            ),
          ],
        ),
      ),
    );
  }
}
