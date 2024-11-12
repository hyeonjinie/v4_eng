import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class MainTopRowWidget extends StatelessWidget {
  final List<Map<String, dynamic>> dataRows;

  MainTopRowWidget({required this.dataRows});

  @override
  Widget build(BuildContext context) {
    return _buildTopRow(context);
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildLeftCell(context, dataRows[0], dataRows[1]),
        ),
        Container(
          width: 1,
          height: 80,
          color: Color(0xFFDDE1E6),
        ),
        Expanded(
          flex: 1,
          child: _buildRightCell(context, dataRows[2]),
        ),
      ],
    );
  }

  // 상단 왼쪽 셀
  Widget _buildLeftCell(BuildContext context, Map<String, dynamic> curr,
      Map<String, dynamic> pred) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F8),
        border: Border(
          top: BorderSide(color: Color(0xFFDDE1E6), width: 1),
          bottom: BorderSide(color: Color(0xFFDDE1E6), width: 1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(curr.keys.first, style: curr.keys.first.length > 15 ? AppTextStyle.light12 : AppTextStyle.light14),
              Spacer(),
              Text(curr.values.first, style: AppTextStyle.medium18),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Text(pred.keys.first, style: pred.keys.first.length > 15 ? AppTextStyle.light12 : AppTextStyle.light14),
              Spacer(),
              Text(pred.values.first, style: AppTextStyle.medium18),
            ],
          ),
        ],
      ),
    );
  }

  // 상단 오른쪽 셀
  Widget _buildRightCell(BuildContext context, Map<String, dynamic> data) {
    bool isMinus = data.values.first.toString().startsWith('-');

    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F8),
        border: Border(
          top: BorderSide(color: Color(0xFFDDE1E6), width: 1),
          bottom: BorderSide(color: Color(0xFFDDE1E6), width: 1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data.keys.first,
            style: AppTextStyle.light14,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            data.values.first,
            style: AppTextStyle.medium16.copyWith(
              color: isMinus ? Color(0xFF2478C7) : Color(0xFFEB5C5C),
              fontSize:
                  data.values.first.length > 10 ? 14 : 16, // 길이에 따라 폰트 크기 조정
            ),
          ),
        ],
      ),
    );
  }
}
