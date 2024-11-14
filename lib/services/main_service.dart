import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:v4/model/main_data.dart';

class MainService {
  final String apiUrl = 'http://43.201.100.40:9001/prediction/home_info';

  // 데이터 가져오기
  Future<MainData> fetchMainData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // response.body를 UTF-8로 디코딩
        final jsonData = json.decode(utf8.decode(response.bodyBytes));
        // jsonData에서 'data' 키로 접근
        return MainData.fromJson(jsonData['data']);
      } else {
        debugPrint('Failed to load main data. Status code: ${response.statusCode}');
        throw Exception('Failed to load main data');
      }
    } catch (e) {
      debugPrint('Error fetching main data: $e');
      throw Exception('Failed to load main data');
    }
  }
}
