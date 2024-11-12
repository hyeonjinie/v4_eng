Map<String, dynamic> generateCalculationData({
  required Map<String, dynamic> growthActualData,
  required Map<String, dynamic> calculationData,
  required int totalCost,
}) {
  int currentGrowth = growthActualData['growthStatus']['overallProgress'].toInt();
  String currencyUnit = calculationData['CurrencyUnit'];
  
  // 예상 수익률 계산
  String expectedProfitRate = totalCost == 0
      ? '-'
      : ((calculationData['PredictedSales'] -
              (calculationData['FinalCost'] +
                  (totalCost - calculationData['CurrentCost']))) /
          calculationData['PredictedSales'] *
          100)
          .toStringAsFixed(2);

  // 최종비용 계산
  dynamic finalCost = totalCost == 0
      ? '-'
      : calculationData['FinalCost'] + (totalCost - calculationData['CurrentCost']);

  // 실제 예상 이익 계산
  dynamic actualExpectedProfit = totalCost == 0
      ? '-'
      : calculationData['PredictedSales'] -
          (calculationData['FinalCost'] +
              (totalCost - calculationData['CurrentCost']));

  return {
    '현재 성장률': currentGrowth,
    '단위': currencyUnit,
    '예상 수익률': expectedProfitRate,
    '현재비용': totalCost,
    '최종비용': finalCost,
    '실제 예상 매출': calculationData['PredictedSales'],
    '실제 예상 이익': actualExpectedProfit,
  };
}
