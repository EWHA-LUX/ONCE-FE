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
import 'package:once_front/src/screens/mypage/card_add_method.dart';
import 'package:once_front/src/screens/mypage/chat_history.dart';
import 'package:once_front/src/screens/mypage/connect_card_company.dart';
import 'package:once_front/src/screens/mypage/maincard_loading.dart';
import 'package:once_front/src/screens/mypage/register_maincard_list.dart';
import 'package:once_front/src/screens/mypage/maincard_manage.dart';
import 'package:once_front/src/screens/mypage/monthly_benefit.dart';
import 'package:once_front/src/screens/mypage/mypage.dart';
import 'package:once_front/src/screens/mypage/codef_terms_conditions.dart';
import 'package:once_front/src/screens/mypage/search_card1.dart';
import 'package:once_front/src/screens/mypage/search_card2.dart';
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
        GetPage(
            name: "/mypage/maincard-manage",
            page: () => const MaincardManage()),
        GetPage(
            name: "/mypage/maincard-manage/add",
            page: () => const CardAddMethod()),
        GetPage(
            name: "/mypage/maincard-manage/add/1",
            page: () => const SearchCard1()),
        GetPage(
            name: "/mypage/maincard-manage/add/2",
            page: () => const SearchCard2()),
        GetPage(name: "/codef", page: () => const RegisterMainCard()),
        GetPage(name: "/codef/2", page: () => const ConnectCardCompany()),
        GetPage(
          name: "/codef/3",
          page: () => ConnectCardCompanyList(
              code: '', id: '', password: ''),
        ),
        GetPage(name: "/loading", page: () => const Loading()),
        GetPage(name: "/maincardloading", page: () => const MainCardLoading(code: '')),
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/signup/1", page: () => Signup1()),
        GetPage(
          name: "/signup/2",
          page: () => Signup2(
              username: '', nickname: '', userPhoneNum: '', birthday: ''),
        ),
        GetPage(name: "/signup/3", page: () => Signup3()),
        GetPage(name: "/signup/4", page: () => Signup4()),
      ],
    );
  }
}
