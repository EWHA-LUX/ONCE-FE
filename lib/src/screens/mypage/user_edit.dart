import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class UserEditPage extends StatelessWidget {
  const UserEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Text('내 정보 수정하기 페이지'),
    );
  }
}
