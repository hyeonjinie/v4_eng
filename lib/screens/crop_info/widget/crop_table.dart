import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class CropInfoTable extends StatelessWidget {
  final List<List<dynamic>> cropInfo;

  const CropInfoTable({Key? key, required this.cropInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double cellWidth = constraints.maxWidth / 2;
          List<TableRow> rows = _buildTableRows(cellWidth);
          
          return Table(
            border: const TableBorder(
              horizontalInside: BorderSide(color: Color(0xFFDDE1E6), width: 1),
            ),
            children: rows,
          );
        },
      ),
    );
  }

  List<TableRow> _buildTableRows(double cellWidth) {
    List<TableRow> rows = [];

    for (int i = 0; i < cropInfo.length; i += 2) {
      List<dynamic> item1 = cropInfo[i];
      List<dynamic>? item2;

      if (i + 1 < cropInfo.length) {
        item2 = cropInfo[i + 1];
      }

      bool isFirstRow = rows.isEmpty;
      rows.add(_buildTableRow(item1, item2, isFirstRow, cellWidth));
    }

    return rows;
  }

  TableRow _buildTableRow(List<dynamic> item1, List<dynamic>? item2, bool isFirstRow, double cellWidth) {
    return TableRow(
      decoration: BoxDecoration(
        color: isFirstRow ? Color(0xFFF8F8F8) : Colors.white,
      ),
      children: [
        _buildTableCell(item1, isFirstRow, cellWidth),
        if (item2 != null)
          _buildTableCell(item2, isFirstRow, cellWidth)
        else 
          Container(),  // 빈 셀 처리
      ],
    );
  }

  Widget _buildTableCell(List<dynamic> item, bool isFirstRow, double cellWidth) {
    return Container(
      width: cellWidth,
      height: 75,
      decoration: BoxDecoration(
        border: Border(
          top: isFirstRow ? const BorderSide(color: Color(0xFFDDE1E6), width: 1) : BorderSide.none,
          bottom: const BorderSide(color: Color(0xFFDDE1E6), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item[0],
            style: AppTextStyle.light14,
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${item[1]}',
                style: AppTextStyle.medium18,
              ),
              Text(
                ' ${item[2]}',
                style: AppTextStyle.light12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
