import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class StageBarWidget extends StatelessWidget {
  final List<dynamic> growthStages;

  const StageBarWidget({
    required this.growthStages,
  });

  @override
  Widget build(BuildContext context) {
    final lastEndMonth = growthStages.last['endMonth'];
    final totalWidth = MediaQuery.of(context).size.width - 48;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              // 각 월 경계에 맞춰 점선 추가
              for (int i = 0; i <= 4; i++) ...[
                Positioned(
                  left: totalWidth / lastEndMonth * i,
                  child: CustomPaint(
                    size: Size(1, 40),
                    painter: DashedLinePainter(),
                  ),
                ),
                // 0개월 텍스트는 생략하고 1개월부터 텍스트 추가
                if (i > 0)
                  Positioned(
                    left: totalWidth / lastEndMonth * i - 35,
                    top: 10,
                    child: Text(
                      i == 1 ? '${i}month' : '${i}months',
                      style: AppTextStyle.light12,
                    ),
                  ),
              ],
              // 프로그레스 바
              Row(
                children: growthStages.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stage = entry.value;
                  final stageWidthFactor =
                      (stage['endMonth'] - stage['startMonth']) / lastEndMonth;

                  return Expanded(
                    flex: (stageWidthFactor * 1000).toInt(),
                    child: Container(
                      margin: EdgeInsets.only(top: 40, bottom: 5),
                      height: 16.0,
                      decoration: BoxDecoration(
                        color:
                            index < 2 ? Color(0xFFD3E9F5) : Color(0xFF78BDA5),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8.0),
                          right: Radius.circular(8.0),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          // 각 구간 중앙에 레이블 표시
          Row(
            children: growthStages.asMap().entries.map((entry) {
              final index = entry.key;
              final stage = entry.value;
              final stageWidthFactor =
                  (stage['endMonth'] - stage['startMonth']) / lastEndMonth;

              // 'label' 값을 영어로 변환하는 함수 정의
              String getEnglishLabel(String koreanLabel) {
                switch (koreanLabel) {
                  case '파종 및 유묘기':
                    return 'Seeding';
                  case '이식기':
                    return 'Transplanting';
                  case '신장기':
                    return 'Vegetative';
                  case '개화기':
                    return 'Flowering';
                  case '성숙기':
                    return 'Maturation';
                  case '수확':
                    return 'Harvest';
                  default:
                    return koreanLabel; // 기본값은 한국어 라벨 그대로
                }
              }

              return Container(
                width: (totalWidth * stageWidthFactor),
                child: Center(
                  child: Text(
                    getEnglishLabel(stage['label']), // 변환된 영어 텍스트를 사용
                    style: AppTextStyle.light12,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    const dashHeight = 4;
    const dashSpace = 3;
    double startY = 0;

    // 점선을 그리는 부분
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
