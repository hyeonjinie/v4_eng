import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RegionalBarWidget extends StatelessWidget {
  final Map<String, Map<String, dynamic>> regionalProduction;
  final Color color;

  const RegionalBarWidget(
      {Key? key, required this.regionalProduction, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: null), // X축 타이틀 숨기기
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: null), // Y축 타이틀 숨기기
        ),
        series: <CartesianSeries>[
          ColumnSeries<RegionData, String>(
            dataSource: _getChartData(),
            xValueMapper: (RegionData data, _) =>
                _getFormattedLabel(data.region),
            yValueMapper: (RegionData data, _) => data.production,
            color: color, // 막대 색상
          ),
        ],
      ),
    );
  }

  List<RegionData> _getChartData() {
    return regionalProduction.entries
        .where((entry) => entry.key != '전체')
        .map((entry) {
      return RegionData(
        region: entry.key,
        production:
            double.tryParse(entry.value['production'].toString()) ?? 0.0,
      );
    }).toList();
  }

  String _getFormattedLabel(String region) {
    switch (region) {
      case '경기도':
        return 'GG';
      case '강원도':
        return 'GW';
      case '충청북도':
        return 'CB';
      case '충청남도':
        return 'CN';
      case '전라북도':
        return 'JB';
      case '전라남도':
        return 'JN';
      case '경상북도':
        return 'GB';
      case '경상남도':
        return 'GN';
      case '제주도':
        return 'JJ';
      case '전체':
        return 'All';
      default:
        return region;
    }
  }
}

class RegionData {
  final String region;
  final double production;

  RegionData({required this.region, required this.production});
}
