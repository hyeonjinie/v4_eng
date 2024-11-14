import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';
import 'package:v4/screens/utils/format/number_format.dart';

class CalculatorTable extends StatelessWidget {
  final Map<String, dynamic> data;

  const CalculatorTable({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          _buildFirstTable(),
          _buildSecondTable(),
        ],
      ),
    );
  }

  Widget _buildFirstTable() {
    return Table(
      border: const TableBorder(
        top: BorderSide(color: Color(0xFFDDE1E6)),
        verticalInside: BorderSide.none,
        horizontalInside: BorderSide(color: Color(0xFFDDE1E6)),
      ),
      children: [
        TableRow(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 50,
              color: Color(0xFFF8F8F8), 
              child: Row(
                children: [
                  Text('Cost Summary', style: AppTextStyle.medium16),
                  Text(
                    '(Growth Rate: ${data['현재 성장률']}%, Unit: ${data['단위']})',
                    style: AppTextStyle.light12,
                  ),
                ],
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 70),
              height: 50,
              child: Row(
                children: [
                  Text('ROI', style: AppTextStyle.regular14),
                  Spacer(),
                  Text('${data.values.elementAt(2)}%', style: AppTextStyle.medium18),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondTable() {
    return Table(
      border: const TableBorder(
        top: BorderSide(color: Color(0xFFDDE1E6)),
        bottom: BorderSide(color: Color(0xFFDDE1E6)),
        verticalInside: BorderSide(color: Color(0xFFDDE1E6)), 
        horizontalInside: BorderSide(color: Color(0xFFDDE1E6)), 
      ),
      children: [
        TableRow(
          children: [
            _buildTableCellWithKeyValue('Current Cost', data['현재비용']),
            _buildTableCellWithKeyValue('Final Cost', data['최종비용']),
          ],
        ),
        TableRow(
          children: [
            _buildTableCellWithKeyValue(data.keys.elementAt(5) == '실제 예상 매출' ? 'Forecast Revenue' : data.keys.elementAt(5), data.values.elementAt(5)),
            _buildTableCellWithKeyValue(data.keys.elementAt(6) == '실제 예상 이익' ? 'Forecast Profit' : data.keys.elementAt(6), data.values.elementAt(6)),
          ],
        ),
      ],
    );
  }

  Widget _buildTableCellWithKeyValue(String key, dynamic value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(key, style: AppTextStyle.light14),
          Text(
            formatCurrency(value),
            style: AppTextStyle.regular16,
          ),
        ],
      ),
    );
  }
}
