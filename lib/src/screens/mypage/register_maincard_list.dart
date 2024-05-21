import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_front/constants.dart';
import 'package:once_front/src/components/empty_app_bar.dart';
import 'package:once_front/src/screens/mypage/maincard_loading.dart';
import 'package:once_front/style.dart';


class ConnectCardCompanyList extends StatefulWidget {
  final String code;
  final String id;
  final String password;

  ConnectCardCompanyList({
    Key? key,
    required this.code,
    required this.id,
    required this.password,
  }) : super(key: key);

  @override
  _ConnectCardCompanyListState createState() => _ConnectCardCompanyListState();
}

class _ConnectCardCompanyListState extends State<ConnectCardCompanyList> {
  final String BASE_URL = Constants.baseUrl;
  late Future<void> _registerMaincardFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _registerMaincardFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainCardLoading(code: widget.code);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // 데이터가 로드된 후에 표시할 화면
          return buildContents(context);
        }
      },
    );
  }

  // 주카드 목록 리스트
  List<Map<String, String>> _maincardList = [];

  @override
  void initState() {
    super.initState();
    _registerMaincardFuture = _getCardList(widget.code, widget.id, widget.password);
  }

  // [Get] 카드 목록 조회
  Future<void> _getCardList(String code, String id, String password) async {
    final String apiUrl = '${BASE_URL}/card/list';

    final storage = FlutterSecureStorage();
    final storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      var response = await dio.post(apiUrl, data: {
        "code": code,
        "id": id,
        "password": password,
      });
      Map<String, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        setState(() {
          _maincardList = List<Map<String, String>>.from(
            (responseData['result'] as List).map((card) => {
              'cardName': card['cardName'].toString(),
              'cardImg': card['cardImg'].toString(),
            }),
          );
        });
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

  // [Post] 주카드 연결
  Future<void> _registerMaincardCodef(String code, String cardName) async {
    final String apiUrl = '${BASE_URL}/card/main';

    final storage = FlutterSecureStorage();
    final storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      var response = await dio.post(apiUrl, data: {
        "code": code,
        "cardName": cardName,
      });

      Map<String, dynamic> responseData = response.data;
      if (responseData['code'] == 1000) {
        print(responseData);
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

  // 상단 뒤로가기 버튼
  Widget _stepArea(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/codef/2");
            },
          ),
        ],
      ),
    );
  }

  Widget _infoArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '주카드 등록',
                style: TextStyles.TitleKorean,
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                '원스에서 관리받고 싶은 주카드를 등록해 보세요.',
                style: TextStyles.SemiTitle,
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            'assets/images/3d_icons/bulb_3d_icon.svg',
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }

  // 주카드 목록 위젯
  Widget _cardList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _maincardList.length,
        itemBuilder: (context, index) {
          final cardName = _maincardList[index]['cardName'] ?? 'Unknown Card';
          final cardImg = _maincardList[index]['cardImg'] ?? 'default_image_url';

          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              height: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  SizedBox(width: 17),
                  widget.code == '0301' ||
                      widget.code == '0306' ||
                      widget.code == '0313' ||
                      widget.code == '0311'
                      ? Transform.rotate(
                    angle: 3.1415926535897932 / 2, // 90 degrees in radians
                    child: CachedNetworkImage(
                      imageUrl: cardImg,
                      width: 63,
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.only(left: 23.0, right: 10),
                    child: CachedNetworkImage(
                      imageUrl: cardImg,
                      width: 41,
                    ),
                  ),
                  SizedBox(width: 17),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cardName,
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17.0, left: 20.0),
                    child: GestureDetector(
                      child: Container(
                        width: 40,
                        height: 22,
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f2f2),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Text(
                            '연결',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              color: Color(0xff0083EE),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        _registerMaincardCodef(widget.code, cardName);
                        Navigator.of(context).pushNamed("/mypage");
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildContents(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: EmptyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _stepArea(context),
          _infoArea(),
          SizedBox(height: 10),
          _cardList(context),
        ],
      ),
    );
  }
}