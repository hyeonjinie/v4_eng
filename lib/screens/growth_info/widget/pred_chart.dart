import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class GrowthTrendChart extends StatelessWidget {
  final List<dynamic?> latestPred;
  final List<String> date;
  final String actualName;
  final String predictedName;
  final String unit;

  GrowthTrendChart({
    required this.latestPred,
    required this.date,
    required this.actualName,
    required this.predictedName,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    
    List<ChartData> predData = List.generate(
      date.length,
      (index) => ChartData(date[index], latestPred[index]),
    );

    final TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);
    final TrackballBehavior trackballBehavior = TrackballBehavior(
      enable: true, // Trackball 활성화
      activationMode: ActivationMode.singleTap, // 탭으로 활성화
      lineType: TrackballLineType.vertical, // 수직선으로 트랙볼 표시
      tooltipSettings: InteractiveTooltip(
        enable: true, // 트랙볼에 툴팁 표시
        color: Colors.black54,
        textStyle: TextStyle(color: Colors.white),
      ),
    );

    return Stack(
      children: [
        // 차트 본체
        SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          legend: Legend(isVisible: true, alignment: ChartAlignment.far),
          tooltipBehavior: tooltipBehavior,
          trackballBehavior: trackballBehavior, // 트랙볼 기능 추가
          series: <CartesianSeries<ChartData, String>>[
            LineSeries<ChartData, String>(
              dataSource: predData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              name: predictedName,
              color: Color(0xFF4F8A97),
              dashArray: <double>[1, 5],
              animationDuration: 0, // 애니메이션 비활성화
              markerSettings: MarkerSettings(
                isVisible: predData.length <= 12,
                height: 4,
                width: 4,
              ),
            ),
          ],
        ),
        // 차트 상단에 텍스트 추가
        Positioned(
          top: 15,
          left: 10, 
          child: Text(
            unit,
            style: AppTextStyle.light12,
          ),
        ),
      ],
    );
  }
}

// 차트 데이터 클래스를 정의
class ChartData {
  final String x;
  final dynamic? y;

  ChartData(this.x, this.y);
}
