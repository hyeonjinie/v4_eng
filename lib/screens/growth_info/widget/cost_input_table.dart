import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class CostInputTableWidget extends StatefulWidget {
  final Map<String, dynamic> costData;
  final Function(int) onTotalCostChanged;

  const CostInputTableWidget({
    Key? key,
    required this.costData,
    required this.onTotalCostChanged,
  }) : super(key: key);

  @override
  _CostTableWidgetState createState() => _CostTableWidgetState();
}

class _CostTableWidgetState extends State<CostInputTableWidget> {
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = widget.costData.map((key, value) {
      return MapEntry(
          key,
          TextEditingController(text: value == 0 ? '' : value.toString()));
    });
    _calculateTotalCost(); // 초기 합계 계산
  }

  void _calculateTotalCost() {
    int total = _controllers.values.fold(
        0,
        (sum, controller) =>
            sum + (int.tryParse(controller.text) ?? 0));
    widget.onTotalCostChanged(total); // 합계를 상위 위젯에 전달
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> buildTableRows() {
      List<TableRow> rows = [];
      List<String> keys = _controllers.keys.toList();

      for (int i = 0; i < keys.length; i += 2) {
        rows.add(
          TableRow(
            children: [
              _buildTitleValueCell(keys[i], _controllers[keys[i]]!),
              if (i + 1 < keys.length)
                _buildTitleValueCell(keys[i + 1], _controllers[keys[i + 1]]!)
              else
                _buildTitleValueCell('', TextEditingController()),
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

  Widget _buildTitleValueCell(String title, TextEditingController controller) {
    return Column(
      children: [
        Container(
          height: 40,
          width: double.infinity,
          color: const Color(0xFFF8F8F8),
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
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter',
            ),
            onTap: () {
              if (controller.text == '0') {
                setState(() {
                  controller.clear();
                });
              }
            },
            onChanged: (value) {
              final number = num.tryParse(value);
              setState(() {
                widget.costData[title] = number ?? 0;
              });
              _calculateTotalCost(); // 입력값 변경 시 합계 업데이트
            },
          ),
        ),
      ],
    );
  }
}
