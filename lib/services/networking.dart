import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String endpoint;

  NetworkHelper(this.endpoint);

  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(endpoint);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
