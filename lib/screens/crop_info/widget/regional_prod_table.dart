import 'package:flutter/material.dart';
import 'package:v4/screens/common/style/text_styles.dart';

class RegionalProdWidget extends StatelessWidget {
  final Map<String, Map<String, dynamic>> regionalProduction;

  const RegionalProdWidget({
    Key? key,
    required this.regionalProduction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // 가로 스크롤 허용
      child: Column(
        children: [
          // 테이블 헤더
          _buildTableHeader(),
          // 지역별 데이터 행
          ...regionalProduction.entries.map((entry) {
            return _buildTableRow(
              region: entry.key,
              data: entry.value,
            );
          }).toList(),
        ],
      ),
    );
  }

  // 테이블 헤더 구성
  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Color(0xFFF8F8F8),
      child: Row(
        children: [
          _buildHeaderCell('Region', width: 80),
          _buildHeaderCell('Area(ha)', width: 90),
          _buildHeaderCell('Yield(ton)', width: 90),
          _buildHeaderCell('Yield per 10a(kg)', width: 100),
        ],
      ),
    );
  }

  // 개별 헤더 셀 생성
  static Widget _buildHeaderCell(String title, {required double width}) {
    return Container(
      width: width,
      child: Center(
        child: Text(
          title,
          style: title.length > 8
              ? AppTextStyle.regular12
              : AppTextStyle.regular14,
        ),
      ),
    );
  }

  // 각 지역별 데이터를 표시하는 테이블 행 구성
  Widget _buildTableRow({
    required String region,
    required Map<String, dynamic> data,
  }) {
    String regionText = region == '경기도'
        ? 'Gyeonggi'
        : region == '강원도'
            ? 'Gangwon'
            : region == '충청북도'
                ? 'Chungbuk'
                : region == '충청남도'
                    ? 'Chungnam'
                    : region == '전라북도'
                        ? 'Jeonbuk'
                        : region == '전라남도'
                            ? 'Jeonnam'
                            : region == '경상북도'
                                ? 'Gyeongbuk'
                                : region == '경상남도'
                                    ? 'Gyeongnam'
                                    : region == '제주도'
                                        ? 'Jeju'
                                        : region == '전체'
                                            ? 'All'
                                            : region;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFDDE1E6), width: 1),
        ),
      ),
      child: Row(
        children: [
          _buildDataCell(regionText, width: 80), // 변환된 시도 이름
          _buildDataCell('${data['area']}', width: 90), // 면적
          _buildDataCell('${data['production']}', width: 90), // 생산량
          _buildDataCell('${data['per_10a']}', width: 100), // 10a당 생산량
        ],
      ),
    );
  }

  // 개별 데이터 셀 생성
  Widget _buildDataCell(String value, {required double width}) {
    return Container(
      width: width,
      child: Center(
        child: Text(
          value,
          style: AppTextStyle.light14,
        ),
      ),
    );
  }
}
