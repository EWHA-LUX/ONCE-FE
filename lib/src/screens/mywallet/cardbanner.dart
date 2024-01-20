class CardBanner {
  final int id;
  final String cardName;
  final String thumbnailUrl;
  final double performance;
  final String remainAmount;

  CardBanner(
      this.id,
      this.cardName,
      this.thumbnailUrl,
      this.performance,
      this.remainAmount,
      );
}

// 샘플 데이터
List<CardBanner> cardBannerList = [
  CardBanner(1, '현대카드M Edition3', 'https://www.hyundaicard.com/img/com/card_big_h/card_ME2_h.png', 0.5, "400,000"),
  CardBanner(2, '현대카드 M2 Boost', 'https://www.hyundaicard.com/img/com/card/card_MBT_h.png', 0.2, "100,000,000"),
  CardBanner(3, '현대카드 MoreOrLess', 'https://img.hyundaicard.com/img/com/card/card_MBT_GI_f.png', 0.8, "777,777"),
];