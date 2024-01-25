import 'dart:math';

class ChatItem {
  final int chatId;
  final String keyword;
  final String cardName;
  final String chatDate;
  final String chatTime;

  ChatItem({
    required this.chatId,
    required this.keyword,
    required this.cardName,
    required this.chatDate,
    required this.chatTime,
  });
}

List<ChatItem> chatDataList = [
  ChatItem(
      chatId: 1,
      keyword: "GS25",
      cardName: "현대 M3 BOOST 카드",
      chatDate: "01.01",
      chatTime: "03:59"),
  ChatItem(
      chatId: 2,
      keyword: "스타벅스",
      cardName: "삼성 iD ON 카드",
      chatDate: "01.01",
      chatTime: "04:59"),
  ChatItem(
      chatId: 3,
      keyword: "이마트24",
      cardName: "우리 카드의정석 체크카드",
      chatDate: "01.01",
      chatTime: "05:59"),
  ChatItem(
      chatId: 4,
      keyword: "CU",
      cardName: "현대카드M Edition3",
      chatDate: "01.01",
      chatTime: "06:59"),
  ChatItem(
      chatId: 5,
      keyword: "CGV",
      cardName: "#any 하나카드",
      chatDate: "01.02",
      chatTime: "12:39"),
  ChatItem(
      chatId: 6,
      keyword: "배달의민족",
      cardName: "국민 행복 카드",
      chatDate: "01.02",
      chatTime: "13:29"),
  ChatItem(
      chatId: 7,
      keyword: "이마트24",
      cardName: "1Q Special+",
      chatDate: "01.02",
      chatTime: "16:11"),
  ChatItem(
      chatId: 8,
      keyword: "세븐일레븐",
      cardName: "신한카드 Unboxing",
      chatDate: "01.02",
      chatTime: "20:12"),
  ChatItem(
      chatId: 9,
      keyword: "GS25",
      cardName: "신한카드 봄",
      chatDate: "01.02",
      chatTime: "12:39"),
  ChatItem(
      chatId: 10,
      keyword: "롯데백화점",
      cardName: "신한카드 Shopping",
      chatDate: "01.02",
      chatTime: "09:29"),
  ChatItem(
      chatId: 11,
      keyword: "스타벅스",
      cardName: "삼성 iD VITA 카드",
      chatDate: "01.02",
      chatTime: "10:55"),
  ChatItem(
      chatId: 12,
      keyword: "아이스크림할인점",
      cardName: "My WE:SH 카드",
      chatDate: "01.02",
      chatTime: "16:14"),
  ChatItem(
      chatId: 13,
      keyword: "배달의민족",
      cardName: "신한카드 봄",
      chatDate: "01.03",
      chatTime: "12:39"),
  ChatItem(
      chatId: 14,
      keyword: "GS25",
      cardName: "가온 Biz카드",
      chatDate: "01.03",
      chatTime: "18:29"),
  ChatItem(
      chatId: 15,
      keyword: "스타벅스",
      cardName: "삼성 iD VITA 카드",
      chatDate: "01.03",
      chatTime: "20:11"),
  ChatItem(
      chatId: 16,
      keyword: "커피빈",
      cardName: "현대카드M Edition3",
      chatDate: "01.04",
      chatTime: "13:58"),
  ChatItem(
      chatId: 17,
      keyword: "GS25",
      cardName: "우리 카드의정석 체크카드",
      chatDate: "01.04",
      chatTime: "23:50"),
  ChatItem(
      chatId: 18,
      keyword: "메가박스",
      cardName: "신한카드 Shopping",
      chatDate: "01.05",
      chatTime: "08:29"),
  ChatItem(
      chatId: 19,
      keyword: "스타벅스",
      cardName: "삼성 iD VITA 카드",
      chatDate: "01.05",
      chatTime: "09:38"),
  ChatItem(
      chatId: 20,
      keyword: "투썸플레이스",
      cardName: "My WE:SH 카드",
      chatDate: "01.05",
      chatTime: "11:13"),
  ChatItem(
      chatId: 21,
      keyword: "롯데시네마",
      cardName: "Our WE:SH 카드",
      chatDate: "01.05",
      chatTime: "12:55"),
  ChatItem(
      chatId: 22,
      keyword: "아이스크림할인점",
      cardName: "WE:SH All 카드",
      chatDate: "01.05",
      chatTime: "20:56"),
];
