class CardBanner {
  final int id;
  final String cardName;
  final String thumbnailUrl;

  CardBanner(this.id, this.cardName, this.thumbnailUrl);
}

// 샘플 데이터
List<CardBanner> cardBannerList = [
  CardBanner(1, '현대카드M', 'https://www.hyundaicard.com/img/com/card_big_h/card_ME2_h.png'),
  CardBanner(2, '현대카드MBoost', 'https://www.hyundaicard.com/img/com/card/card_MBT_h.png'),
  CardBanner(3, '현대카드MoreOrLess', 'https://img.hyundaicard.com/img/com/card/card_MBT_GI_f.png'),
];