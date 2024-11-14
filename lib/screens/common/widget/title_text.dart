import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;

  const CustomTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Text(
        text,
        style: AppTextStyle.medium18,
      ),
    );
  }
}
