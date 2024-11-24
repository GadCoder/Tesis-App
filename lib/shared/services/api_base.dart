import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiBase {
  static const String baseURL = "192.168.18.10:8000";

  Future<http.Response> makeGetRequest(String endpointUrl) async {
    var url = Uri.http(baseURL, endpointUrl);
    print(url);
    Map<String, String> headers = {
      'accept': 'application/json',
    };
    final response = await http.get(url);

    return response;
  }
}
