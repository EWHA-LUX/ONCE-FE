import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:once_front/constants.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class UserEditPage extends StatefulWidget {
  const UserEditPage({Key? key}) : super(key: key);

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  late String userNickname = '';
  late String userId = '';
  late String userName = '';
  late String userBirth = '';
  late String userPhoneNum = '';
  late String userSignupDate = '';
  late String userProfileImg = '';

  late String oriPassword = '';
  late String newPassword = '';

  final String BASE_URL = Constants.baseUrl;

  bool isNameEdit = false;
  bool isNicknameEdit = false;
  bool isBirthEdit = false;
  bool isPhoneNumEdit = false;
  late bool isTruePassword = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController phonenumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getMyProfileEdit(context);
  }

  void _updateState() {
    setState(() {
      isTruePassword = true;
    });
  }

  // [Post] 비밀번호 확인
  Future<void> _checkPassword(BuildContext context) async {
    final String apiUrl = '${BASE_URL}/user/edit/pw';

    final storage = FlutterSecureStorage();
    final storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      final response = await dio.post(
        apiUrl,
        data: {
          'password': oriPassword,
        },
      );

      final responseData = response.data['result'];

      if (responseData == true) {
        _updateState();
      }
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
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        return;
      }
      String imagePath = pickedFile.path;

      var formData = FormData.fromMap(
          {'userProfileImg': await MultipartFile.fromFile(imagePath)});

      final response = await dio.patch(
        apiUrl,
        data: formData,
      );
      print(response);

      final newImageUrl =
          '${response.data['result']}?${DateTime.now().millisecondsSinceEpoch}';
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
                    shape: BoxShape.circle, color: Colors.white),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    width: 174,
                    height: 174,
                    child: CachedNetworkImage(
                      imageUrl:
                          '$userProfileImg?timestamp=${DateTime.now().millisecondsSinceEpoch}' ??
                              '',
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
            padding: EdgeInsets.only(
                top: 257, left: MediaQuery.of(context).size.width / 2 + 45),
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
              child: isNicknameEdit
                  ? SizedBox(
                      width: 40,
                      height: 19,
                      child: TextField(
                        controller: nicknameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: userNickname,
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      '$userNickname 님',
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 7, top: 310),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isNicknameEdit) {
                        _updateUserProfile(context);
                        userNickname = nicknameController.text;
                      }
                      isNicknameEdit = !isNicknameEdit;
                    });
                  },
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    child: SvgPicture.asset(
                      isNicknameEdit
                          ? 'assets/images/icons/edit_check_icon.svg'
                          : 'assets/images/icons/edit_icon.svg',
                      width: isNicknameEdit ? 21 : 19,
                    ),
                  ),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 335),
              child: Text(
                userId,
                style: const TextStyle(
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
        const Padding(
          padding: EdgeInsets.only(left: 35, top: 35),
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
                const Padding(
                  padding: EdgeInsets.only(left: 35, top: 100),
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
                  child: isNameEdit
                      ? SizedBox(
                          width: 120,
                          height: 19,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: userName,
                              hintStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                      : Text(
                          userName,
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: isNameEdit ? 43 : 121,
                      top: 100,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isNameEdit) {
                            _updateUserProfile(context);
                            userName = nameController.text;
                          }
                          isNameEdit = !isNameEdit;
                        });
                      },
                      child: SvgPicture.asset(
                        isNameEdit
                            ? 'assets/images/icons/edit_check_icon.svg'
                            : 'assets/images/icons/edit_icon.svg',
                        width: isNameEdit ? 22 : 20,
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 35, top: 17),
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
                  child: isBirthEdit
                      ? SizedBox(
                          width: 120,
                          height: 19,
                          child: TextField(
                            controller: birthController,
                            decoration: InputDecoration(
                              hintText: userBirth,
                              hintStyle: const TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                      : userBirth != ""
                          ? Text(
                              userBirth,
                              style: const TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  isBirthEdit = true;
                                });
                              },
                              child: Container(
                                width: 115,
                                height: 23,
                                decoration: const BoxDecoration(
                                  color: Color(0xffececec),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                ),
                                child: const Center(
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
                Padding(
                  padding: EdgeInsets.only(
                    left: userBirth != "" ? 80 : 49,
                    top: 17,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isBirthEdit) {
                          _updateUserProfile(context);
                          userBirth = birthController.text;
                        }
                        isBirthEdit = !isBirthEdit;
                      });
                    },
                    child: SvgPicture.asset(
                      isBirthEdit
                          ? 'assets/images/icons/edit_check_icon.svg'
                          : 'assets/images/icons/edit_icon.svg',
                      width: isBirthEdit ? 22 : 20,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 36, top: 17),
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
                  child: isPhoneNumEdit
                      ? SizedBox(
                          width: 120,
                          height: 19,
                          child: TextField(
                            controller: phonenumController,
                            decoration: InputDecoration(
                              hintText: userPhoneNum,
                              hintStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                      : Text(
                          userPhoneNum,
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: isPhoneNumEdit ? 43 : 45,
                      top: 17,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isPhoneNumEdit) {
                            _updateUserProfile(context);
                            userPhoneNum = phonenumController.text;
                          }
                          isPhoneNumEdit = !isPhoneNumEdit;
                        });
                      },
                      child: SvgPicture.asset(
                        isPhoneNumEdit
                            ? 'assets/images/icons/edit_check_icon.svg'
                            : 'assets/images/icons/edit_icon.svg',
                        width: isPhoneNumEdit ? 22 : 20,
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 35, top: 17),
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
                      decoration: const BoxDecoration(
                        color: Color(0xffececec),
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      child: const Center(
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
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Container(
                                height: 560,
                                margin: const EdgeInsets.only(
                                  top: 20,
                                  left: 25,
                                  right: 25,
                                  bottom: 30,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          child: const Icon(Icons.close),
                                          onTap: () {
                                            Navigator.pop(context);
                                            setState(() {
                                              oriPassword = '';
                                              newPassword = '';
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    isTruePassword
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text('비밀번호 변경',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                        '새로운 비밀번호를 입력해 주세요.',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff767676))),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 40.0,
                                                              bottom: 35.0),
                                                      child: Row(
                                                        children: List.generate(
                                                            6, (index) {
                                                          if (index <
                                                              newPassword
                                                                  .length) {
                                                            return _passwordCircle(
                                                                true);
                                                          } else {
                                                            return _passwordCircle(
                                                                false);
                                                          }
                                                        }),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '1'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword +=
                                                                  '1';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '2'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword +=
                                                                  '2';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '3'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword +=
                                                                  '3';
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '4'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword +=
                                                                  '4';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '5'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword +=
                                                                  '5';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '6'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword +=
                                                                  '6';
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '7'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword +=
                                                                  '7';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '8'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword +=
                                                                  '8';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '9'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword +=
                                                                  '9';
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '⌫'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword = newPassword
                                                                  .substring(
                                                                      0,
                                                                      oriPassword
                                                                              .length -
                                                                          1);
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '0'),
                                                          onTap: () {
                                                            setState(() {
                                                              newPassword +=
                                                                  '0';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '✓'),
                                                          onTap: () {
                                                            print(newPassword);
                                                            // ************ 변경
                                                            _checkPassword(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text('비밀번호 확인',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black)),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                        '본인 확인을 위해 기존 비밀번호를 입력해 주세요.',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff767676))),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 40.0,
                                                              bottom: 35.0),
                                                      child: Row(
                                                        children: List.generate(
                                                            6, (index) {
                                                          if (index <
                                                              oriPassword
                                                                  .length) {
                                                            return _passwordCircle(
                                                                true);
                                                          } else {
                                                            return _passwordCircle(
                                                                false);
                                                          }
                                                        }),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '1'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword +=
                                                                  '1';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '2'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword +=
                                                                  '2';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '3'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword +=
                                                                  '3';
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '4'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword +=
                                                                  '4';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '5'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword +=
                                                                  '5';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '6'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword +=
                                                                  '6';
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '7'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword +=
                                                                  '7';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '8'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword +=
                                                                  '8';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '9'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword +=
                                                                  '9';
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '⌫'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword = oriPassword
                                                                  .substring(
                                                                      0,
                                                                      oriPassword
                                                                              .length -
                                                                          1);
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '0'),
                                                          onTap: () {
                                                            setState(() {
                                                              oriPassword +=
                                                                  '0';
                                                            });
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          child: _passwordInput(
                                                              '✓'),
                                                          onTap: () {
                                                            print(oriPassword);
                                                            _checkPassword(
                                                                context);
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        400),
                                                                () {
                                                              setState(() {});
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            });
                          });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 35, top: 17),
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
                    style: const TextStyle(
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
    );
  }

  // Widget _passwordCheck() {
  //   return
  // }
  Widget _passwordInput(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 30.0),
      child: Text(text,
          style: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 27,
              fontWeight: FontWeight.w200,
              color: Colors.black)),
    );
  }

  Widget _passwordCircle(bool isTrue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: 15,
        height: 15,
        decoration: isTrue
            ? const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color(0xff4472fc),
                    Color(0xff8877d5),
                  ],
                ))
            : const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xffE2E2E2)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _gradationBody(context),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2 - 175.0,
                  top: 370),
              child: _profileContainer(context),
            ),
          ],
        ),
      ),
    );
  }
}
