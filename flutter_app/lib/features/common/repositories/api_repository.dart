import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiRepository {

  final String rootUrl;

  ApiRepository() : rootUrl = dotenv.env['API_URL'] ?? '';

  Future<String> fetchData(String endpoint, {String params = ''}) async {
    // TODO:WSL上のubuntuのIPは動的に割り当てられるので確認する必要がある
    String url = '$rootUrl/$endpoint';
    if (params.isNotEmpty) {
      url = '$url?$params';
    }
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

   Future<String> postData(String endpoint, Map<String, dynamic> data) async {
    String url = '$rootUrl/$endpoint';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to post data');
    }
  }
}
