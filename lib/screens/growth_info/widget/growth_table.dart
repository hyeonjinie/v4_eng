import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class GrowthTableWidget extends StatelessWidget {
  final List<List<String>> dataRows; // Dynamic data rows

  GrowthTableWidget({required this.dataRows});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopRow(context),  
          _buildDataGrid(context),  
        ],
      ),
    );
  }

  // 1행 2열의 상단 영역을 Row로 구성
  Widget _buildTopRow(BuildContext context) {
    return Row(
      children: [
        _buildTopCell(context, dataRows[0][0], dataRows[0][1]),
        Container(
          width: 1,  
          height: 65,  
          color: Color(0xFFDDE1E6),  
        ),
        _buildTopCell(context, dataRows[1][0], dataRows[1][1]),
      ],
    );
  }

  // 상단 영역에 들어갈 셀
  Widget _buildTopCell(BuildContext context, String title, String value) {
    return Expanded(
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: const BoxDecoration(
          color: Color(0xFFF8F8F8),
          border: Border(
            top: BorderSide(color: Color(0xFFDDE1E6), width: 1),
            bottom: BorderSide(color: Color(0xFFDDE1E6), width: 1),
          ),
        ),
        child: Column(
          children: [
            Text(title, style: AppTextStyle.light14),
            SizedBox(height: 4),
            Text(value, style: AppTextStyle.medium16),
          ],
        ),
      ),
    );
  }

  // 데이터를 1행 3열로 보여주는 함수
  Widget _buildDataGrid(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDataCell(context, dataRows[2][0], dataRows[2][1]),  
        _buildDataCell(context, dataRows[3][0], dataRows[3][1]),  
        _buildDataCell(context, dataRows[4][0], dataRows[4][1]),  
      ],
    );
  }

  // 데이터를 포함하는 셀을 구성하는 함수
  Widget _buildDataCell(BuildContext context, String title, String value) {
    // value의 첫 글자를 기반으로 색상 결정
    Color getValueColor(String value) {
      if (value.startsWith('▲')) {
        return const Color(0xFFEB5C5C);  
      } else if (value.startsWith('▼')) {
        return const Color(0xFF0084FF);  
      } else {
        return Colors.black;  
      }
    }

    return Expanded(
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFDDE1E6), width: 1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: title.length > 8
                  ? AppTextStyle.light12
                  : AppTextStyle.light14,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: (value.length > 10
                  ? AppTextStyle.medium12.copyWith(color: getValueColor(value))
                  : AppTextStyle.medium16
                      .copyWith(color: getValueColor(value))),
            ),
          ],
        ),
      ),
    );
  }
}
