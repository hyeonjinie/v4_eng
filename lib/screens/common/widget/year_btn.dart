import 'package:flutter/material.dart';

class YearButtonWidget extends StatefulWidget {
  final List<String> availableYears;
  final List<String> selectedYears;
  final void Function(List<String>) onYearsChanged;
  final Map<String, Color> yearColorMap;
  final bool isContinuousView; // 그래프 이어서 보기 상태

  YearButtonWidget({
    required this.availableYears,
    required this.selectedYears,
    required this.onYearsChanged,
    required this.yearColorMap,
    required this.isContinuousView,
  });

  @override
  _YearButtonWidgetState createState() => _YearButtonWidgetState();
}

class _YearButtonWidgetState extends State<YearButtonWidget> {
  @override
  Widget build(BuildContext context) {
    double btnWidth;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: widget.availableYears.map((year) {
          // 그래프 이어서 보기 활성화 시 평년 버튼 숨기기
          if (widget.isContinuousView && year == '평년') {
            return SizedBox.shrink(); // 비활성화된 위젯으로 대체
          }

          final isSelected = widget.selectedYears.contains(year);
          final yearColor =
              widget.yearColorMap[year] ?? const Color(0xFFE1E1E1);
          btnWidth = year.length < 2 ? 50 : 60;

          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: year.length < 2 ? 3.0 : 5.0),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isSelected) {
                      widget.selectedYears.remove(year);
                    } else {
                      widget.selectedYears.add(year);
                    }
                    widget.onYearsChanged(widget.selectedYears);
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(btnWidth, 35),
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                      color: isSelected ? yearColor : const Color(0xFFE1E1E1),
                      width: isSelected ? 2.0 : 1.0,
                    ),
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    year == '해당없음'
                        ? 'N/A'
                        : year == '평년'
                            ? 'Avg.'
                            : year == '경기'
                                ? 'Gyeonggi'
                                : year == '강원'
                                    ? 'Gangwon'
                                    : year == '충청북도'
                                        ? 'Chungbuk'
                                        : year == '충청남도'
                                            ? 'Chungnam'
                                            : year == '전라북도'
                                                ? 'Jeonbuk'
                                                : year == '전라남도'
                                                    ? 'Jeonnam'
                                                    : year == '경상북도'
                                                        ? 'Gyeongbuk'
                                                        : year == '경상남도'
                                                            ? 'Gyeongnam'
                                                            : year == '제주'
                                                                ? 'Jeju'
                                                                : year == '전체'
                                                                    ? 'All'
                                                                    : year,
                    style: TextStyle(
                      color: isSelected ? yearColor : const Color(0xFF9CA1AB),
                    ),
                  ),
                )),
          );
        }).toList(),
      ),
    );
  }
}
