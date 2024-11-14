import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class AnalysisWidget extends StatelessWidget {
  final String title;
  final Map<String, dynamic> actAnalysis;
  final String availableYear;
  final int resMonth;

  const AnalysisWidget({
    Key? key,
    required this.title,
    required this.actAnalysis,
    required this.availableYear,
    required this.resMonth,
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
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: Offset(0, 3),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: AppTextStyle.medium16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '$availableYear년 $resMonth월',
                  style: AppTextStyle.light16,
                  textAlign: TextAlign.right,
                ),
                Spacer(),
                Text(
                  actAnalysis['this_value'].toString(),
                  style: AppTextStyle.semibold30,
                ),
                const Text(
                  ' ton',
                  style: AppTextStyle.light16,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            _buildDataRow('전월대비', actAnalysis['value_compared_last_value'],
                actAnalysis['rate_compared_last_value']),
            _buildDataRow('전년대비', actAnalysis['value_compared_last_year'],
                actAnalysis['rate_compared_last_year']),
            _buildDataRow('평년대비', actAnalysis['value_compared_common_3years'],
                actAnalysis['rate_compared_common_3years']),
          ],
        ),
      ),
    );
  }

  // 정보창 데이터행(xx대비)
  Widget _buildDataRow(String label, dynamic value, dynamic per) {
    String symbol = value < 0 ? '▼' : '▲';
    String formattedValue = symbol + value.abs().toString();

    Color valueColor =
        value < 0 ? const Color(0xFF2478C7) : const Color(0xFFEB5C5C);
    Color perColor =
        per < 0 ? const Color(0xFF2478C7) : const Color(0xFFEB5C5C);

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
            formattedValue,
            style: AppTextStyle.light16
                .copyWith(color: valueColor)
                .copyWith(height: 1.0),
          ),
          Text(
            per.toString() + '%',
            style: AppTextStyle.light16
                .copyWith(color: perColor)
                .copyWith(height: 1.0),
          ),
        ],
      ),
    );
  }
}
