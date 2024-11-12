// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:v4/model/price_data.dart';

// class PriceService {
//   final String url = 'http://43.201.100.40:9001/prediction/price_info';

//   Future<PriceInfoResponse> fetchPriceInfo() async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(utf8.decode(response.bodyBytes));
//         return PriceInfoResponse.fromJson(data['selectedCrops']);
//       } else {
//         print('Failed to load data. Status code: ${response.statusCode}');
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//       throw Exception('Error fetching data');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class PriceService {
  final String url = 'http://43.201.100.40:9001/prediction/price_info';

  Future<Map<String, dynamic>> fetchPriceInfo() async {
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
