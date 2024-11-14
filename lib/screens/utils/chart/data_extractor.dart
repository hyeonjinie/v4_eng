List<Map<String, dynamic>> extractLatestPrices(
    Map<String, dynamic> priceData, int count) {
  // 결과를 저장할 리스트
  List<Map<String, dynamic>> pred_price = [];

  // 월 이름 리스트
  List<String> months = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];

  // 연도를 최신순으로 정렬
  List<String> years = priceData.keys.toList();
  years.removeWhere((year) => year == '평년' || year == 'act_analysis' || year == 'pred_analysis');
  years.sort((a, b) => int.parse(b).compareTo(int.parse(a))); // 내림차순 정렬

  // 가장 최신 데이터 count개를 추출
  int extractedCount = 0;
  for (String year in years) {
    var prices = priceData[year];

    if (prices is List) {
      for (int i = 11; i >= 0 && extractedCount < count; i--) {
        if (prices[i] != null) {
          pred_price.add({
            "year": int.parse(year),
            "month": months[i],
            "value": prices[i]
          });
          extractedCount++;
        }
      }
    }
  }

  return pred_price;
}
