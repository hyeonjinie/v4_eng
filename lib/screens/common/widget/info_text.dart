import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class InfoTextWidget extends StatelessWidget {
  final String text; 

  InfoTextWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), 
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFF787878),
            size: 14,
          ),
          SizedBox(width: 4), 
          Text(
            text,
            style: AppTextStyle.light12,
          ),
        ],
      ),
    );
  }
}
