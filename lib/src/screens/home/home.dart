import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:once_front/src/components/empty_app_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // bottomsheet 아이콘 위젯
  Widget _navbarCircle(String imagePath, String menuName) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Color(0xffeeeeee)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: SizedBox(
              width: 40,
              height: 40,
              child: SvgPicture.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(menuName, style: const TextStyle(fontFamily: 'Pretendard',
              fontSize: 13,
              fontWeight: FontWeight.w400),),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 28.0, top: 35.0),
            child: Text(
              'ONCE',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 28.0, top: 1),
                child: Text(
                  '결제 전 가장 혜택이 좋은 카드를 추천드려요.',
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      color: Color(0xff767676)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 27),
                child: SvgPicture.asset(
                  'assets/images/icons/alarm_icon.svg',
                  width: 28,
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      builder: (BuildContext context) {
                        return Container(
                            height: 230,
                            margin: const EdgeInsets.only(
                              top: 20,
                              left: 25,
                              right: 25,
                              bottom: 30,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      child: const Icon(Icons.close), onTap: () {
                                      Navigator.pop(context);
                                    },),
                                  ],
                                ),
                                Row(
                                  // 마이월렛, 월별혜택조회, 마이페이지
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: _navbarCircle(
                                          'assets/images/3d_icons/wallet_3d_icon.svg',
                                          '마이월렛'),
                                      onTap: () {
                                        Navigator.of(context).pushNamed("/mywallet");
                                      },
                                    ),
                                    const SizedBox(width: 30,),
                                    GestureDetector(
                                      child: _navbarCircle(
                                          'assets/images/3d_icons/graph_3d_icon.svg',
                                          '월별 혜택 조회'),
                                      onTap: () {
                                        Navigator.of(context).pushNamed("/mypage/benefit");
                                      },
                                    ),
                                    const SizedBox(width: 30,),
                                    GestureDetector(
                                      child: _navbarCircle(
                                          'assets/images/3d_icons/mypage_3d_icon.svg',
                                          '마이페이지'),
                                      onTap: () {
                                        Navigator.of(context).pushNamed("/mypage");
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Row(
                                    // 설정, 로그아웃
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: _navbarCircle(
                                            'assets/images/3d_icons/setting_3d_icon.svg',
                                            '설정'),
                                        onTap: () {
                                          Navigator.of(context).pushNamed("/setting");
                                        },
                                      ),
                                      const SizedBox(width: 30,),
                                      GestureDetector(
                                        child: _navbarCircle(
                                            'assets/images/3d_icons/logout_3d_icon.svg',
                                            '로그아웃'),
                                        onTap: (){

                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      });
                },
                child: SvgPicture.asset(
                  "assets/images/icons/menu_icon.svg",
                  width: 35,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SvgPicture.asset(
                            "assets/images/icons/send_icon.svg",
                            width: 10,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color(0xffADADAD))),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        hintText: '궁금한 것을 질문해 보세요.',
                        hintStyle: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffADADAD))),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
