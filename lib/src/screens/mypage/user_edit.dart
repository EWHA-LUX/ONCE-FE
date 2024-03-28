import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class UserEditPage extends StatefulWidget {
  const UserEditPage({Key? key}) : super(key: key);

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  late String userNickname= '';
  late String userId = '';
  late String userName = '';
  late String userBirth = '';
  late String userPhoneNum = '';
  late String userSignupDate = '';
  late String userProfileImg = '';

  final String BASE_URL = Constants.baseUrl;

  @override
  void initState() {
    super.initState();
    _getMyProfileEdit(context);
  }

  // [Get] 내 정보 수정하기 조회
  Future<void> _getMyProfileEdit(BuildContext context) async {
    final String apiUrl = '${BASE_URL}/user/edit';

    final storage = FlutterSecureStorage();
    final storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      final response = await dio.get(apiUrl);
      print(response);
      final responseData = response.data['result'];
      setState(() {
        userNickname = responseData['nickname'];
        userId = responseData['loginId'];
        userName = responseData['username'];
        userBirth = responseData['birthday'];
        userPhoneNum = responseData['userPhoneNum'];
        userSignupDate = responseData['createdAt'];
        userProfileImg = responseData['userProfileImg'];
      });
    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("오류 발생"),
            content: Text("서버와 통신 중 오류가 발생했습니다."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

  // [Patch] 유저 프로필 수정
  Future<void> _updateUserProfile(BuildContext context) async {
    final String apiUrl = '${BASE_URL}/user/edit';

    final storage = FlutterSecureStorage();
    final storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      final response = await dio.patch(
        apiUrl,
        data: {
          'username': userName,
          'nickname': userNickname,
          'birthday': userBirth,
          'userPhoneNum': userPhoneNum,
        },
      );
    } catch (e) {
      print('오류 발생: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("오류 발생"),
            content: Text("서버와 통신 중 오류가 발생했습니다."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

  // [Patch] 유저 프로필 이미지 수정
  Future<void> _updateUserProfileImg(BuildContext context) async {
    final String apiUrl = '${BASE_URL}/user/edit/profile';

    final storage = FlutterSecureStorage();
    final storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {
        'Authorization': 'Bearer $storedAccessToken',
        'Content-Type': 'multipart/form-data'
      },
    );

    final dio = Dio(baseOptions);

    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        return;
      }
      String imagePath = pickedFile.path;

      var formData = FormData.fromMap({
        'userProfileImg' : await MultipartFile.fromFile(imagePath)
      });

      final response = await dio.patch(
        apiUrl,
        data: formData,
      );
      print(response);

      final newImageUrl = '${response.data['result']}?${DateTime.now().millisecondsSinceEpoch}';
      setState(() {
        userProfileImg = newImageUrl;
      });
    } catch (e) {
      print('오류 발생: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("오류 발생"),
            content: Text("서버와 통신 중 오류가 발생했습니다."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _gradationBody(context) {
    return Stack(
      children: [
        Container(
          height: 455,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xff4472fc),
                Color(0xff8877d5),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(300.0, 130.0),
              bottomRight: Radius.elliptical(300.0, 130.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25, top: 65),
          child: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.back();
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 65),
              child: Text(
                '내 정보 수정하기',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 123),
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    width: 174,
                    height: 174,
                    child: CachedNetworkImage(
                      imageUrl: userProfileImg ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => _updateUserProfileImg(context),
          child: Padding(
            padding: EdgeInsets.only(top: 257, left: MediaQuery.of(context).size.width / 2 + 45),
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffeeeeee),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/icons/camera_icon.svg',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 310),
              child: Text(
                '$userNickname 님',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 335),
              child: Text(
                userId,
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffc5c5c5),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _profileContainer(context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: Container(
            width: 350,
            height: 340,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35, top: 35),
          child: Text(
            '기본 정보',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 100),
                  child: Text(
                    '이름',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8d8d8d),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80, top: 100),
                  child: Text(
                    userName,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 17),
                  child: Text(
                    '생년월일',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8d8d8d),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 17),
                  child: userBirth != ""
                      ? Text(
                    userBirth,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      // 생년월일 입력으로 넘어가기
                    },
                    child: Container(
                      width: 115,
                      height: 23,
                      decoration: BoxDecoration(
                        color: Color(0xffececec),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      child: Center(
                        child: Text(
                          '생년월일 입력하기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff727272),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 17),
                  child: Text(
                    '휴대폰번호',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8d8d8d),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 37, top: 17),
                  child: Text(
                    userPhoneNum,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45, top: 17),
                  child: SvgPicture.asset(
                    'assets/images/icons/edit_icon.svg',
                    width: 20,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 17),
                  child: Text(
                    '비밀번호',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8d8d8d),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 17),
                  child: GestureDetector(
                    child: Container(
                      width: 115,
                      height: 23,
                      decoration: BoxDecoration(
                        color: Color(0xffececec),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '비밀번호 변경하기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff727272),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 17),
                  child: Text(
                    '가입일',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8d8d8d),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 67, top: 17),
                  child: Text(
                    userSignupDate,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ) ;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Stack(
        children: [
          _gradationBody(context),
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 175.0, top: 370),
            child: _profileContainer(context),
          ),
        ],
      ),
    );
  }
}