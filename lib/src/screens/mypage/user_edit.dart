import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

class UserEditPage extends StatelessWidget {
  const UserEditPage({super.key});

  final String userNickname = "루스";
  final String userId = "luxlux0101";
  final String userName = "김수진";
  final String userBirth = "";
  final String userPhoneNum = "010-1234-5678";
  final String userPassword = "";
  final String userSignupDate = "2024.01.01";
  final String userProfileImg = "https://i.pinimg.com/originals/f1/5d/1a/f15d1a3ba005d7f28b72d3b9dee53cdd.jpg";

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
        Row(
          children: [
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
            Padding(
              // 가운데 정렬하는 방법 찾아보기 -------------------------------------
              // Expanded, Center 불가능
              padding: EdgeInsets.only(top: 65, left: 95),
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
        Padding(
          padding: EdgeInsets.only(top: 123, left: MediaQuery.of(context).size.width / 2 - 78.0),
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
                  imageUrl: userProfileImg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 257, left: MediaQuery.of(context).size.width / 2 + 48.0),
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
                color: Colors.black,
              ),
            ),
          ),
        ),
        // 가운데 정렬하는 방법 찾아보기 -------------------------------------
        Padding(
          padding: EdgeInsets.only(top: 310, left: 183),
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
        // 가운데 정렬하는 방법 찾아보기 -------------------------------------
        Padding(
          padding: EdgeInsets.only(top: 335, left: 170),
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
                  padding: const EdgeInsets.only(left: 40, top: 17),
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
                  padding: const EdgeInsets.only(left: 70, top: 17),
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