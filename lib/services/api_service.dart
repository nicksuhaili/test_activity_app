import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://bored.api.lewagon.com/api/activity";

  Future<Map<String, dynamic>> fetchRandomActivity({String? type}) async {
    final response = await http.get(
      Uri.parse(type != null ? '$_baseUrl?type=$type' : _baseUrl),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load activity');
    }
  }
}
