import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class ProgressBarWidget extends StatelessWidget {
  final double progressRate; // 진행률 (0.0 to 1.0)
  final String barColor;

  ProgressBarWidget({
    required this.progressRate,
    required this.barColor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 프로그레스 바 및 마커와 텍스트
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final progressBarWidth = constraints.maxWidth;
              final markerPosition = progressBarWidth * progressRate;

              return Stack(
                clipBehavior: Clip.none, // 클립을 없애서 바깥으로 나간 부분도 보이도록 설정
                children: [
                  // 고정된 바 배경
                  Container(
                    height: 16.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  // 진행률 바
                  FractionallySizedBox(
                    widthFactor: progressRate,
                    child: Container(
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: barColor == 'curr'? Color(0xFF87C46D) : Color(0xFF3EB080),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  // 마커
                  Positioned(
                    left: markerPosition - 24, // 마커 중앙 맞춤을 위한 조정
                    top: -8.0, // 마커가 바 위로 완전히 올라가도록 위치 조정
                    child: Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: barColor == 'curr'? Color(0xFFD3E9B8).withOpacity(0.7) : Color(0xFF3EB080).withOpacity(0.2),
                      ),
                      child: Center(
                        child: Container(
                          width: 16.0,
                          height: 16.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, 
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 진행률 텍스트를 마커 위에 배치
                  Positioned(
                    left: markerPosition - 24, // 마커 위치에 맞춰 텍스트 위치 조정
                    top: -35.0, // 텍스트를 마커 위쪽에 배치
                    child: Text(
                      '${(progressRate * 100).toInt()}%',
                      style: AppTextStyle.medium16,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
