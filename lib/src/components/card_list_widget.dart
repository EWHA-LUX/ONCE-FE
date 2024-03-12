import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:once_front/constants.dart';

class CardListWidget extends StatefulWidget {
  bool isMain;
  bool isCreditCard;
  String cardName;
  String cardCompany;
  String cardImg;
  int ownedCardId;
  final VoidCallback onUpdate;

  CardListWidget({
    Key? key,
    required this.isMain,
    required this.isCreditCard,
    required this.cardName,
    required this.cardCompany,
    required this.cardImg,
    required this.ownedCardId,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<CardListWidget> createState() => _CardListWidgetState();
}

class _CardListWidgetState extends State<CardListWidget> {
  final String BASE_URL = Constants.baseUrl;

  // 삭제 완료 alert 확인 누르면 상태 업데이트
  void handleButtonClick() {
    widget.onUpdate();
  }

  void _deleteCard(BuildContext context, int ownedCardId) async {
    final String apiUrl = '${BASE_URL}/mypage/maincard';

    const storage = FlutterSecureStorage();
    String? storedAccessToken = await storage.read(key: 'accessToken');

    final baseOptions = BaseOptions(
      headers: {'Authorization': 'Bearer $storedAccessToken'},
    );

    final dio = Dio(baseOptions);

    try {
      var response = await dio.delete('$apiUrl/$ownedCardId');
      Map<dynamic, dynamic> responseData = response.data;
      print(responseData);

      if (responseData['code'] == 1000) {
        handleButtonClick();
      }
    } catch (e) {
      // ** 차후 수정 필요 **
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

  Widget _snackBarContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/icons/snackbar_icon.png',
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 20.0,
          ),
          const Text(
            '카드가 삭제되었어요.',
            style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          )
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: const Color(0xff3B3B3B),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      duration: const Duration(seconds: 3),
      content: _snackBarContent(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 340,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              widget.cardCompany == '국민카드' ||
                      widget.cardCompany == '신한카드' ||
                      widget.cardCompany == '하나카드' ||
                      widget.cardCompany == '롯데카드'
                  ? Transform.rotate(
                      angle: 3.1415926535897932 / 2, // 90 degrees in radians
                      child: CachedNetworkImage(
                        imageUrl: widget.cardImg,
                        width: 63,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 10),
                      child: CachedNetworkImage(
                        imageUrl: widget.cardImg,
                        width: 41,
                      ),
                    ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 140,
                            child: Text(
                              widget.cardName,
                              style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          widget.isMain
                              ? Image.asset(
                                  'assets/images/icons/crown_icon.png',
                                  width: 15,
                                  height: 15,
                                )
                              : const SizedBox(width: 0)
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "# ${widget.cardCompany} # ${widget.isCreditCard ? "신용카드" : "체크카드"}",
                        style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff767676)),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
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
                        '삭제',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          color: Color(0xffFF7070),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    _deleteCard(context, widget.ownedCardId);
                    showSnackBar(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
