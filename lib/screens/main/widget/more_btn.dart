import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class MoreButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed; // 클릭 시 실행할 함수

  const MoreButtonWidget({Key? key, required this.title, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.medium18,
        ),
        Spacer(),
        GestureDetector(
          // 클릭 이벤트 처리
          onTap: onPressed,
          child: Container(
            width: 85,
            height: 30,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0xFF9D9D9D),
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'more ',
                        style: AppTextStyle.light14, // AppTextStyle에서 가져온 스타일
                      ),
                      TextSpan(
                        text: '>',
                        style: AppTextStyle.light14, // AppTextStyle에서 가져온 스타일
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
