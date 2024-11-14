import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // intl 패키지 임포트

class MainCardWidget extends StatelessWidget {
  final String prod;
  final String optimalPurchaseTime;

  const MainCardWidget({
    Key? key,
    required this.prod,
    required this.optimalPurchaseTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentDate =
        DateFormat('yyyy.MM.dd').format(DateTime.now()); // 오늘 날짜 형식 설정

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 배경 이미지
        Container(
          height: 280,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/png/home_banner.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 배너 카드
        Positioned(
          top: 150, // 배경 이미지 안쪽에 겹치도록 위치 조정
          left: 16,
          right: 16,
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                center: Alignment.topLeft,
                radius: 1.5,
                colors: [
                  Color.fromRGBO(255, 255, 255, 0.08),
                  Color.fromRGBO(255, 255, 255, 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: Colors.white.withOpacity(0.6),
                width: 1.0,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentDate,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Optimal Purchase Timing for \'Perilla\'',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Dec.2024',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
