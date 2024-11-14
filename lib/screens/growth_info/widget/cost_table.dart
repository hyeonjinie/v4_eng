import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';
import 'package:v4/screens/utils/format/number_format.dart';

class CostTableWidget extends StatelessWidget {
  final Map<String, dynamic> costData;

  const CostTableWidget({Key? key, required this.costData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // costData에서 2개씩 묶어서 테이블을 생성
    List<TableRow> buildTableRows() {
      List<TableRow> rows = [];
      List<String> keys = costData.keys.toList();
      List<dynamic> values = costData.values.toList();

      for (int i = 0; i < keys.length; i += 2) {
        rows.add(
          TableRow(
            children: [
              _buildTitleValueCell(keys[i], values[i]),
              if (i + 1 < keys.length)
                _buildTitleValueCell(keys[i + 1], values[i + 1])
              else
                _buildTitleValueCell('', ''),
            ],
          ),
        );
      }
      return rows;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Table(
        border: const TableBorder(
          top: BorderSide(color: Color(0xFFDDE1E6), width: 1),
          bottom: BorderSide(color: Color(0xFFDDE1E6), width: 1),
          verticalInside: BorderSide(color: Color(0xFFDDE1E6), width: 1), 
        ),
        columnWidths: const {
          0: FlexColumnWidth(1), 
          1: FlexColumnWidth(1), 
        },
        children: buildTableRows(),
      ),
    );
  }

  // 타이틀과 값을 위아래로 나열하는 셀 디자인 (타이틀에 배경색 추가)
  Widget _buildTitleValueCell(String title, dynamic value) {
    return Column(
      children: [
        Container(
          height: 40,  
          width: double.infinity,
          color: Color(0xFFF8F8F8),
          alignment: Alignment.center, 
          child: Text(
            title,
            textAlign: TextAlign.center, 
            style: AppTextStyle.regular14,
          ),
        ),
        Container(
          height: 40,  
          width: double.infinity,
          alignment: Alignment.center, 
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFDDE1E6), width: 1), 
            ),
          ),
          child: Text(
            formatCurrency(value),
            textAlign: TextAlign.center, 
            style: AppTextStyle.light14,
          ),
        ),
      ],
    );
  }
}
