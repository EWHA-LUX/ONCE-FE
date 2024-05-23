import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

import 'package:firebase_messaging/firebase_messaging.dart';

import 'constants.dart';

void main() async {
  print("1");
  WidgetsFlutterBinding.ensureInitialized();
  print("2");
  await Firebase.initializeApp(); // Firebase 초기화
  print("3");
  final token = await FirebaseMessaging.instance.getToken();
  print("4");
  if (token != null) {
    print("FCM Token: $token");
    await sendTokenToServer(token); // 서버에 토큰 전송
  } else {
    print("FCM Token이 null입니다.");
  }

  runApp(const MyApp());
  getPerformanceData();
}

void getPerformanceData() async {
  final String BASE_URL = Constants.baseUrl;
  final String apiUrl = '$BASE_URL/card/main/performance';

  const storage = FlutterSecureStorage();
  String? storedAccessToken = await storage.read(key: 'accessToken');

  if (storedAccessToken != null) {
    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      final response = await dio.get(apiUrl);
      final responseData = response.data;
      print(responseData);
    } catch (e) {
      print(e.toString());
    }
  } else {
    print('AccessToken 없음');
  }
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

Future<void> sendTokenToServer(String token) async {
  final String BASE_URL = Constants.baseUrl;
  final String apiUrl = '$BASE_URL/user/token';

  const storage = FlutterSecureStorage();
  String? storedAccessToken = await storage.read(key: 'accessToken');

  if (storedAccessToken != null) {
    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      var response =
      await dio.post(apiUrl, data: {"token": token});
      Map<dynamic, dynamic> responseData = response.data;
      print(responseData);
    } catch (e) {
      print('토큰 전송 오류: $e');
    }
  } else {
    print('AccessToken 없음');
  }
}
