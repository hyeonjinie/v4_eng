import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:v4/screens/common/style/text_styles.dart';
import 'package:v4/screens/common/widget/info_text.dart';
import 'package:v4/screens/utils/format/number_format.dart';

class LineChart extends StatefulWidget {
  final Map<String, dynamic> statisticData;

  LineChart({
    required this.statisticData,
  });

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  late List<dynamic> dates;
  late List<dynamic> values;
  double maxAmtValue = 0;
  int? selectedButtonIndex;
  Key chartKey = UniqueKey();
  String infoText = 'Selected → Worldwide'; 

  @override
  void initState() {
    super.initState();
    dates = List<dynamic>.from(widget.statisticData['world_to_world']['date']);
    values = List<dynamic>.from(widget.statisticData['world_to_world']['data']);

    // 모든 amt 값 중 최대값을 구하여 maxAmtValue에 저장
    maxAmtValue = widget.statisticData['country_amt_top5_list']
        .map((item) => double.tryParse(item['amt'].toString()) ?? 0.0)
        .reduce((a, b) => a > b ? a : b);
  }

  /// 차트 데이터를 업데이트하고 Key를 변경하여 차트를 다시 렌더링하는 함수
  void updateChartData(int index, String buttonName) {
    setState(() {
      if (selectedButtonIndex == index) {
        dates = List<dynamic>.from(widget.statisticData['world_to_world']['date']);
        values = List<dynamic>.from(widget.statisticData['world_to_world']['data']);
        selectedButtonIndex = null;
        infoText = 'Selected → Worldwide'; // 기본 메시지로 돌아감
      } else {
        dates = List<dynamic>.from(
            widget.statisticData['country_amt_top5_list'][index]['date']);
        values = List<dynamic>.from(
            widget.statisticData['country_amt_top5_list'][index]['data']);
        selectedButtonIndex = index;
        infoText = buttonName; // 클릭한 버튼명으로 변경
      }
      chartKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InfoTextWidget(text: infoText),
          SizedBox(
            height: 300,
            child: simpleLineChart(dates, values, chartKey),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                widget.statisticData['country_amt_top5_list'].length, (index) {
              final exp =
                  widget.statisticData['country_amt_top5_list'][index]['exp'];
              final imp =
                  widget.statisticData['country_amt_top5_list'][index]['imp'];
              final amt = double.tryParse(widget
                      .statisticData['country_amt_top5_list'][index]['amt']
                      .toString()) ??
                  0.0;

              return Row(
                children: [
                  // 고정된 너비의 텍스트 버튼 (사각형 스타일 및 왼쪽 정렬)
                  SizedBox(
                    width: 140, // 고정 너비 설정
                    child: TextButton(
                      onPressed: () => updateChartData(index, '$exp > $imp'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: selectedButtonIndex == index
                            ? Color(0xFFF8F8F8) // 클릭 시 색상 변경
                            : Colors.transparent,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        textStyle: AppTextStyle.light14,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$exp > $imp',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.left, // 왼쪽 정렬 설정
                          ),
                        ],
                      ),
                    ),
                  ),

                  // amt 비율에 따른 사각형 프로그레스바 추가
                  Expanded(
                    child: Container(
                      height: 14,
                      color: Colors.grey[300],
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: amt / maxAmtValue,
                        child: Container(
                          color: Color(0xFFFF9900),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // amt 텍스트 표시
                  Text(
                    formatCurrency(amt),
                    style: AppTextStyle.light12,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  // 라인 차트를 생성하는 함수 (Key 추가)
  Widget simpleLineChart(List<dynamic> dates, List<dynamic> values, Key key) {
  return SfCartesianChart(
    key: key,
    primaryXAxis: CategoryAxis(),
    primaryYAxis: NumericAxis(isVisible: false), // Y축 레이블 숨김
    tooltipBehavior: TooltipBehavior(enable: true),

    // 트랙볼 설정 (클릭 시 좌우 호버 이동 가능)
    trackballBehavior: TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap, // 클릭으로 활성화
      tooltipAlignment: ChartAlignment.near,
      tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
      lineType: TrackballLineType.vertical,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        color: Colors.black,
        textStyle: TextStyle(color: Colors.white),
      ),
    ),

    series: <LineSeries<dynamic, dynamic>>[
      LineSeries<dynamic, dynamic>(
        dataSource: List.generate(dates.length, (index) => index),
        xValueMapper: (index, _) => dates[index],
        yValueMapper: (index, _) => values[index],
        width: 2,
        color: Color(0xFFFFBB00),
        animationDuration: 0,

        markerSettings: const MarkerSettings(
          isVisible: true,
          width: 4,
          height: 4,
          shape: DataMarkerType.circle,
          borderWidth: 2,
          borderColor: Color(0xFFFF9900),
        ),
      )
    ],
  );
}

}
