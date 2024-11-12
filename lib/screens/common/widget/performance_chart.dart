import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class HalfDoughnutChart extends StatelessWidget {
  final double value;
  final String title;

  const HalfDoughnutChart({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyle.medium16,
        ),
        Container(
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SfCircularChart(
                series: <DoughnutSeries>[
                  // 배경용 시리즈 (전체)
                  DoughnutSeries<ChartData, String>(
                    dataSource: [ChartData(100)], // 배경을 위한 전체 원
                    xValueMapper: (ChartData data, _) => '',
                    yValueMapper: (ChartData data, _) => data.value,
                    innerRadius: '84%',
                    radius: '100%',
                    startAngle: 240,
                    endAngle: 480,
                    pointColorMapper: (ChartData data, _) => Color(0xFFE1E1E1),
                    dataLabelSettings: DataLabelSettings(isVisible: false),
                    animationDuration: 0,
                  ),
                  // 실제 값 시리즈
                  DoughnutSeries<ChartData, String>(
                    dataSource: [ChartData(value)],
                    xValueMapper: (ChartData data, _) => '',
                    yValueMapper: (ChartData data, _) => data.value,
                    innerRadius: '84%',
                    radius: '100%',
                    startAngle: 240,
                    endAngle: (240 + (value / 100) * 240).toInt(),
                    pointColorMapper: (ChartData data, _) => Color(0xFF2478C7),
                    dataLabelSettings: DataLabelSettings(isVisible: false),
                  ),
                ],
              ),
              // 도넛 차트 안에 값을 표시하기 위한 Text 위젯
              Text(
                '${value.toStringAsFixed(2)}%', 
                style: AppTextStyle.semibold20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartData {
  final double value;

  ChartData(this.value);
}
