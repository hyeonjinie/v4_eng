import 'package:flutter/material.dart';

class GradeButtonWidget extends StatefulWidget {
  final Function(String) onGradeChanged;
  final List<String> btnNames;
  final String selectedBtn;

  const GradeButtonWidget({
    Key? key,
    required this.onGradeChanged,
    required this.btnNames,
    required this.selectedBtn,
  }) : super(key: key);

  @override
  _GradeButtonWidgetState createState() => _GradeButtonWidgetState();
}

class _GradeButtonWidgetState extends State<GradeButtonWidget> {
  late String selectedBtn;

  @override
  void initState() {
    super.initState();
    selectedBtn = widget.selectedBtn;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: widget.btnNames.map((grade) {
          final isSelected = selectedBtn == grade;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedBtn = grade;
                });
                widget.onGradeChanged(grade);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(60, 35),
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: isSelected
                        ? const Color(0xFF0084FF)
                        : const Color(0xFFE1E1E1),
                    width: isSelected ? 2.0 : 1.0,
                  ),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  grade == '해당없음'
                      ? 'N/A'
                      : grade == '기온'
                          ? 'Temp'
                          : grade == '강수량'
                              ? 'Rainfall'
                              : grade == '습도'
                                  ? 'Humid'
                                  : grade == '경기'
                                      ? 'Gyeonggi'
                                      : grade == '강원'
                                          ? 'Gangwon'
                                          : grade == '충청북도'
                                              ? 'Chungbuk'
                                              : grade == '충청남도'
                                                  ? 'Chungnam'
                                                  : grade == '전라북도'
                                                      ? 'Jeonbuk'
                                                      : grade == '전라남도'
                                                          ? 'Jeonnam'
                                                          : grade == '경상북도'
                                                              ? 'Gyeongbuk'
                                                              : grade == '경상남도'
                                                                  ? 'Gyeongnam'
                                                                  : grade ==
                                                                          '제주'
                                                                      ? 'Jeju'
                                                                      : grade ==
                                                                              '전체'
                                                                          ? 'All'
                                                                          : grade,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF0084FF)
                        : const Color(0xFF9CA1AB),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
