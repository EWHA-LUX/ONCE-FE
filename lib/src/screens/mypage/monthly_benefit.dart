import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class MonthlyBenefit extends StatelessWidget {
  const MonthlyBenefit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Text('monthly benefit page'),
    );
  }
}
