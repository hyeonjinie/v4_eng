import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CropChart extends StatefulWidget {
  final List<String> selectedRegions;
  final Map<String, List<double>> currentProductionData;
  final Map<String, Color> gradeColorMap;
  final String unit;

  const CropChart({
    Key? key,
    required this.selectedRegions,
    required this.currentProductionData,
    required this.gradeColorMap,
    required this.unit,
  }) : super(key: key);

  @override
  _CropChartState createState() => _CropChartState();
}

class _CropChartState extends State<CropChart> {
  @override
  Widget build(BuildContext context) {
    return _buildChart();
  }

  // 그래프 그리기
  Widget _buildChart() {
    final TrackballBehavior trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
      ),
      lineType: TrackballLineType.vertical,
      markerSettings: const TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible),
    );

    return Container(
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        // tooltipBehavior: tooltipBehavior,
        trackballBehavior: trackballBehavior,
        series: widget.selectedRegions.map((region) {
          List<double> filteredData =
              widget.currentProductionData[region] ?? [];
          // List<String> xLabels = List<String>.generate(filteredData.length, (index) => (index + 1).toString());

          int currentYear = DateTime.now().year;
          List<String> xLabels = List<String>.generate(
                  10, (index) => (currentYear - index).toString())
              .reversed
              .toList();

          return LineSeries<double, String>(
            name: region,
            dataSource: filteredData,
            xValueMapper: (double data, int index) => xLabels[index],
            yValueMapper: (double data, _) => data,
            color: widget.gradeColorMap[region],
            animationDuration: 0,
          );
        }).toList(),
      ),
    );
  }
}
