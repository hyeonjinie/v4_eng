import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:v4/data/mock/growth_mock.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class GrowthChart extends StatefulWidget {
  final List<String> selectedYears;
  final Map<String, List<double>> currentProductionData;
  final bool isContinuousView;
  final ValueChanged<bool> onToggleView;
  final Map<String, Color> yearColorMap;
  final String unit;
  final String hoverText;

  const GrowthChart({
    Key? key,
    required this.selectedYears,
    required this.currentProductionData,
    required this.isContinuousView,
    required this.onToggleView,
    required this.yearColorMap,
    required this.unit,
    required this.hoverText,
  }) : super(key: key);

  @override
  _CurrentChartState createState() => _CurrentChartState();
}

class _CurrentChartState extends State<GrowthChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildToggleButton(),
        const SizedBox(height: 16),
        _buildChart(),
      ],
    );
  }

  // '그래프 이어서 보기' 토글 버튼
  Widget _buildToggleButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.unit,
            style: AppTextStyle.light14,
          ),
          Spacer(),
          const Text(
            'Connect selected',
            style: AppTextStyle.light14,
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              widget.onToggleView(!widget.isContinuousView);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: 45,
              height: 26,
              decoration: BoxDecoration(
                color: widget.isContinuousView
                    ? Color(0xFF39739D)
                    : Color(0xFFDEDEDE),
                borderRadius: BorderRadius.circular(16.0),
                border: widget.isContinuousView
                    ? Border.all(color: Color(0xFF39739D), width: 2)
                    : Border.all(color: Color(0xFFDEDEDE), width: 2),
              ),
              child: AnimatedAlign(
                duration: Duration(milliseconds: 200),
                alignment: widget.isContinuousView
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                curve: Curves.easeInOut,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 그래프 그리기
Widget _buildChart() {
  final TooltipBehavior tooltipBehavior = TooltipBehavior(
    enable: true,
    format: widget.hoverText,
  );

  final TrackballBehavior trackballBehavior = TrackballBehavior(
    enable: true,
    activationMode: ActivationMode.singleTap, // 터치할 때 트랙볼 활성화
    tooltipSettings: InteractiveTooltip(
      enable: true,
      format: widget.hoverText,
    ),
    lineType: TrackballLineType.vertical, // 수평으로 호버 이펙트 표시
    markerSettings: TrackballMarkerSettings(markerVisibility: TrackballVisibilityMode.visible),
  );

  List<String> monthDayLabels = [];
  for (int i = 1; i <= 12; i++) {
    for (int j = 1; j <= _daysInMonth(i); j++) {
      monthDayLabels.add('${i}/${j}');
    }
  }

  if (widget.isContinuousView) {
    // '그래프 이어서 보기'가 활성화된 경우
    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            // x값에서 연도만 추출해서 레이블로 표시
            String label = details.text;
            List<String> parts = label.split('년');
            return ChartAxisLabel(parts[0] + '년', null);
          },
        ),
        tooltipBehavior: tooltipBehavior,
        trackballBehavior: trackballBehavior, // 트랙볼 추가
        series: [
          LineSeries<Map<String, dynamic>, String>(
            name: '연속 그래프',
            dataSource: _buildCombinedData(),
            xValueMapper: (Map<String, dynamic> data, _) => data['x'],
            yValueMapper: (Map<String, dynamic> data, _) => data['y'],
            markerSettings: MarkerSettings(isVisible: false),
            color: Colors.blue,
            animationDuration: 0,
          ),
        ],
      ),
    );
  } else {
    // 개별 연도 그래프
    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        tooltipBehavior: tooltipBehavior,
        trackballBehavior: trackballBehavior, // 트랙볼 추가
        series: widget.selectedYears
            .where((year) => !(widget.isContinuousView && year == '평년'))
            .map((year) {
          List<double> filteredData =
              widget.currentProductionData[year] ?? [];
          return LineSeries<double, String>(
            name: year,
            dataSource: filteredData,
            xValueMapper: (double? data, int index) => monthDayLabels[index],
            yValueMapper: (double data, _) => data,
            markerSettings: MarkerSettings(isVisible: false),
            color: widget.yearColorMap[year],
            animationDuration: 0,
          );
        }).toList(),
      ),
    );
  }
}

  // 선택된 연도들의 데이터를 합쳐서 연속된 리스트 생성
  List<Map<String, dynamic>> _buildCombinedData() {
    List<Map<String, dynamic>> combinedData = [];

    for (var year in widget.selectedYears) {
      if (year == '평년') continue;
      List<double> monthlyData = widget.currentProductionData[year] ?? [];
      int dayCounter = 1;

      // 각 연도의 데이터를 월별로 처리
      for (int month = 1; month <= 12; month++) {
        int daysInMonth = _daysInMonth(month); // 각 월의 일 수 가져오기

        for (int day = 1;
            day <= daysInMonth && dayCounter <= monthlyData.length;
            day++) {
          combinedData.add({
            'x': '$year년 $month월 $day일',
            'y': monthlyData[dayCounter - 1],
            'year': int.parse(year),
            'month': month,
            'day': day,
          });
          dayCounter++;
        }
      }
    }

    // 연속 데이터이므로 정렬
    combinedData.sort((a, b) {
      int yearComparison = a['year'].compareTo(b['year']);
      if (yearComparison == 0) {
        int monthComparison = a['month'].compareTo(b['month']);
        if (monthComparison == 0) {
          return a['day'].compareTo(b['day']);
        }
        return monthComparison;
      }
      return yearComparison;
    });

    return combinedData;
  }

// 각 월의 날짜 수를 반환하는 헬퍼 함수
  int _daysInMonth(int month) {
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      case 2:
        return 28; // 윤년은 고려하지 않음
      default:
        return 30;
    }
  }
}
