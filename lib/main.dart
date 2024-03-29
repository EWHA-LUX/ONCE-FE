import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:once_front/src/screens/home/home.dart';
import 'package:once_front/src/screens/home/notification.dart';
import 'package:once_front/src/screens/home/setting.dart';
import 'package:once_front/src/screens/login/loading.dart';
import 'package:once_front/src/screens/login/login.dart';
import 'package:once_front/src/screens/login/signup1.dart';
import 'package:once_front/src/screens/login/signup2.dart';
import 'package:once_front/src/screens/login/signup3.dart';
import 'package:once_front/src/screens/login/signup4.dart';
import 'package:once_front/src/screens/mypage/chat_history.dart';
import 'package:once_front/src/screens/mypage/maincard_manage.dart';
import 'package:once_front/src/screens/mypage/monthly_benefit.dart';
import 'package:once_front/src/screens/mypage/mypage.dart';
import 'package:once_front/src/screens/mypage/register_maincard.dart';
import 'package:once_front/src/screens/mypage/user_edit.dart';
import 'package:once_front/src/screens/mywallet/mywallet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(),
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/", page: () => const Home()),
        GetPage(name: "/notification", page: () => const PushNotification()),
        GetPage(name: "/setting", page: () => const Setting()),
        GetPage(name: "/mywallet", page: () => const MyWallet()),
        GetPage(name: "/mypage", page: () => const MyPage()),
        GetPage(name: "/mypage/edit", page: () => const UserEditPage()),
        GetPage(name: "/mypage/benefit", page: () => MonthlyBenefit()),
        GetPage(name: "/mypage/chat-history", page: () => const ChatHistory()),
        GetPage(name: "/mypage/maincard-manage", page: () => const MaincardManage()),
        GetPage(name: "/codef", page: () => const RegisterMainCard()),
        GetPage(name: "/loading", page: () => const Loading()),
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/signup/1", page: () => Signup1()),
        GetPage(
          name: "/signup/2",
          page: () => Signup2(username: '', nickname: '', userPhoneNum: '', birthday: ''),
        ),
        GetPage(name: "/signup/3", page: () => Signup3()),
        GetPage(name: "/signup/4", page: () => Signup4()),
      ],
    );
  }
}
