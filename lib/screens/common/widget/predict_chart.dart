import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PredictChart extends StatefulWidget {
  final String selectedGrade;
  final Map<String, List<int>> predictData;
  final String unit;
  final String hoverText;

  const PredictChart({
    Key? key,
    required this.selectedGrade,
    required this.predictData,
    required this.unit,
    required this.hoverText,
  }) : super(key: key);

  @override
  State<PredictChart> createState() => _PredictChartState();
}

class _PredictChartState extends State<PredictChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildChart(),
      ],
    );
  }

  Widget _buildChart() {
    final TooltipBehavior tooltipBehavior = TooltipBehavior(
      enable: true,
      format: widget.hoverText,
    );

    List<String> monthNames = [
      '1월',
      '2월',
      '3월',
      '4월',
      '5월',
      '6월',
      '7월',
      '8월',
      '9월',
      '10월',
      '11월',
      '12월'
    ];

    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelRotation: -30,
          desiredIntervals: -5,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        tooltipBehavior: tooltipBehavior,
        // series: widget.selectedGrade
        //     .where((grade) => )
        //     .map((grade) {
        //   List<int> filteredData = widget.currentProductionData[year] ?? [];
        //   return LineSeries<int, String>(
        //     name: year,
        //     dataSource: filteredData,
        //     xValueMapper: (int data, int index) =>
        //         monthNames[index], // x축 값으로 월 이름 사용
        //     yValueMapper: (int data, _) => data,
        //     markerSettings: MarkerSettings(isVisible: true),
        //     color: widget.yearColorMap[year],
        //     animationDuration: 0,
        //   );
        // }).toList(),
      ),
    );
  }
}
