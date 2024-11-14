class PriceInfoResponse {
  final Map<String, Crop> selectedCrops;

  PriceInfoResponse({required this.selectedCrops});

  factory PriceInfoResponse.fromJson(Map<String, dynamic> json) {
    return PriceInfoResponse(
      selectedCrops: (json['selectedCrops'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(key, Crop.fromJson(value)),
      ),
    );
  }
}

class Crop {
  final List<String> markets;
  final Map<String, PriceCategory> prices;

  Crop({required this.markets, required this.prices});

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      markets: List<String>.from(json['markets'] ?? []),
      prices: (json['prices'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(key, PriceCategory.fromJson(value)),
      ),
    );
  }
}

class PriceCategory {
  final Map<String, ActualPrice> actualPrice;
  final Map<String, PredictedPrice> predictedPrice;

  PriceCategory({required this.actualPrice, required this.predictedPrice});

  factory PriceCategory.fromJson(Map<String, dynamic> json) {
    return PriceCategory(
      actualPrice: (json['실제가격'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(key, ActualPrice.fromJson(value)),
      ),
      predictedPrice: (json['예측가격'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(key, PredictedPrice.fromJson(value)),
      ),
    );
  }
}

class ActualPrice {
  final Map<String, List<double?>>? prices;
  final ActAnalysis? analysis;

  ActualPrice({this.prices, this.analysis});

  factory ActualPrice.fromJson(Map<String, dynamic> json) {
    return ActualPrice(
      prices: (json['해당없음'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>? ?? []).map((v) => v is num ? v.toDouble() : null).toList(),
        ),
      ),
      analysis: json['act_analysis'] != null
          ? ActAnalysis.fromJson(json['act_analysis'])
          : null,
    );
  }
}

class PredictedPrice {
  final Map<String, List<double?>>? prices;
  final PredAnalysis? analysis;

  PredictedPrice({this.prices, this.analysis});

  factory PredictedPrice.fromJson(Map<String, dynamic> json) {
    return PredictedPrice(
      prices: (json['해당없음'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>? ?? []).map((v) => v is num ? v.toDouble() : null).toList(),
        ),
      ),
      analysis: json['pred_analysis'] != null
          ? PredAnalysis.fromJson(json['pred_analysis'])
          : null,
    );
  }
}

class ActAnalysis {
  final String date;
  final double thisValue;
  final double rateComparedLastValue;
  final double diffComparedLastValueYear;
  final double valueComparedLastYear;
  final double rateComparedLastYear;
  final double valueComparedCommon3Years;
  final double diffValueComparedCommon3Years;
  final double rateComparedCommon3Years;
  final double yearAverageValue;
  final double yearChangeValue;
  final double seasonalIndex;
  final double supplyStabilityIndex;
  final String currencyUnit;
  final String weightUnit;

  ActAnalysis({
    required this.date,
    required this.thisValue,
    required this.rateComparedLastValue,
    required this.diffComparedLastValueYear,
    required this.valueComparedLastYear,
    required this.rateComparedLastYear,
    required this.valueComparedCommon3Years,
    required this.diffValueComparedCommon3Years,
    required this.rateComparedCommon3Years,
    required this.yearAverageValue,
    required this.yearChangeValue,
    required this.seasonalIndex,
    required this.supplyStabilityIndex,
    required this.currencyUnit,
    required this.weightUnit,
  });

  factory ActAnalysis.fromJson(Map<String, dynamic> json) {
    return ActAnalysis(
      date: json['date'] ?? '',
      thisValue: (json['this_value'] ?? 0).toDouble(),
      rateComparedLastValue: (json['rate_compared_last_value'] ?? 0).toDouble(),
      diffComparedLastValueYear: (json['diff_compared_last_value_year'] ?? 0).toDouble(),
      valueComparedLastYear: (json['value_compared_last_year'] ?? 0).toDouble(),
      rateComparedLastYear: (json['rate_compared_last_year'] ?? 0).toDouble(),
      valueComparedCommon3Years: (json['value_compared_common_3years'] ?? 0).toDouble(),
      diffValueComparedCommon3Years: (json['diff_value_compared_common_3years'] ?? 0).toDouble(),
      rateComparedCommon3Years: (json['rate_compared_common_3years'] ?? 0).toDouble(),
      yearAverageValue: (json['year_average_value'] ?? 0).toDouble(),
      yearChangeValue: (json['year_change_value'] ?? 0).toDouble(),
      seasonalIndex: (json['seasonal_index'] ?? 0).toDouble(),
      supplyStabilityIndex: (json['supply_stability_index'] ?? 0).toDouble(),
      currencyUnit: json['currency_unit'] ?? '',
      weightUnit: json['weight_unit'] ?? '',
    );
  }
}

class PredAnalysis {
  final String date;
  final double predictedPrice;
  final double rateComparedLastValue;
  final List<double> range;
  final double outOfRangeProbability;
  final double stabilitySectionProbability;
  final double consistencyIndex;
  final double seasonallyAdjustedPrice;
  final double signalIndex;
  final String currencyUnit;
  final String weightUnit;

  PredAnalysis({
    required this.date,
    required this.predictedPrice,
    required this.rateComparedLastValue,
    required this.range,
    required this.outOfRangeProbability,
    required this.stabilitySectionProbability,
    required this.consistencyIndex,
    required this.seasonallyAdjustedPrice,
    required this.signalIndex,
    required this.currencyUnit,
    required this.weightUnit,
  });

  factory PredAnalysis.fromJson(Map<String, dynamic> json) {
    return PredAnalysis(
      date: json['date'] ?? '',
      predictedPrice: (json['predicted_price'] ?? 0).toDouble(),
      rateComparedLastValue: (json['rate_compared_last_value'] ?? 0).toDouble(),
      range: List<double>.from(json['range']?.map((x) => x.toDouble()) ?? []),
      outOfRangeProbability: (json['out_of_range_probability'] ?? 0).toDouble(),
      stabilitySectionProbability: (json['stability_section_probability'] ?? 0).toDouble(),
      consistencyIndex: (json['consistency_index'] ?? 0).toDouble(),
      seasonallyAdjustedPrice: (json['seasonally_adjusted_price'] ?? 0).toDouble(),
      signalIndex: (json['signal_index'] ?? 0).toDouble(),
      currencyUnit: json['currency_unit'] ?? '',
      weightUnit: json['weight_unit'] ?? '',
    );
  }
}
