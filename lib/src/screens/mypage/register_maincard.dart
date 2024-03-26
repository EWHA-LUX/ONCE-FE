import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class RegisterMainCard extends StatelessWidget {
  const RegisterMainCard({super.key});

  Widget _termsArea(context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 2 - 290,
      ),
      child: Center(
        child: Container(
          width: 335,
          height: 480,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.3,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                )
              ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff666666),
        appBar: EmptyAppBar(),
        body: Column(
          children: [
            _termsArea(context),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: const Text('취소',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline,
                      color: Color(0xffADADAD))),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
}
