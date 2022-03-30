import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map> getRestauran() async {
    Uri url = Uri.parse("https://restaurant-api.dicoding.dev/list");
    try {
      final response = await http.get(url);
      return Future.value(
        {
          'statusCode': response.statusCode,
          'allRestauran' : (jsonDecode(response.body))['restaurants'],
          'restaurant':(jsonDecode(response.body))['restaurants']
        }
      );
    } catch (errorException) {
      return Future.error(errorException);
    }
  }
}