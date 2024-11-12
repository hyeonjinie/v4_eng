import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class PerformanceWidget extends StatelessWidget {
  final Map<String, dynamic> info;
  final String type;

  const PerformanceWidget({
    Key? key,
    required this.info,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDataRow('MAPE(오차평균)', info['MAPE'], '%'),
            _buildDataRow(type == '가격'?'최소오차 가격':'최소오차 생산량', info['minimum_diff'], type == '가격'?'원':'톤'),
            _buildDataRow(type == '가격'?'최대오차 가격':'최대오차 생산량', info['maximum_diff'], type == '가격'?'원':'톤'),
            const SizedBox(height: 16,),
            const Text('** MAPE : 실제값과 예측값 차이의 절대값 평균', style: AppTextStyle.light14,),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, dynamic value, String unit) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyle.light16.copyWith(height: 1.0),
          ),
          Text(
            value.toString() + unit,
            style: AppTextStyle.light16
                .copyWith(height: 1.0),
          ),
        ],
      ),
    );
  }
}
