import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class DropdownWidget extends StatelessWidget {
  final List<dynamic> options;
  final String selectedValue;
  final ValueChanged<dynamic?> onChanged;

  const DropdownWidget({
    Key? key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButton<dynamic>(
          value: selectedValue,
          items: options.map((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value ,
              child: Text(
                value == '한국' ? 'Korea' : value,
                style: AppTextStyle.regular16,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: Colors.white,
          icon: Image.asset('assets/icon/arrow_down.png', width: 20, height: 20),
          style: const TextStyle(color: Color(0xFF363B45)),
          underline: const SizedBox(),
          isExpanded: true,
        ),
      ),
    );
  }
}
