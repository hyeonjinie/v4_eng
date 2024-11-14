import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class CustomWhiteButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;

  const CustomWhiteButton({
    Key? key,
    required this.buttonName,
    required this.onPressed, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
      ),
      child: Container(
        width: 135,
        height: 48,
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.57, color: Colors.white),
            borderRadius: BorderRadius.circular(11.39),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: AppTextStyle.regular16.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed; 

  const CustomTextButton({
    Key? key,
    required this.buttonName,
    required this.onPressed, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: onPressed,
      child: Text(
        buttonName,
        style: AppTextStyle.regular16.copyWith(color: Colors.white), 
        textAlign: TextAlign.center,
      ),
    );
  }
}
