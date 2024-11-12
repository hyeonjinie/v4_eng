import 'dart:convert';
import 'package:http/http.dart' as http;

class CropService {
  final String url = 'http://43.201.100.40:9001/prediction/harvest_info';

  Future<Map<String, dynamic>> fetchCropInfo() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error fetching data: $e');
      return {};
    }
  }
}