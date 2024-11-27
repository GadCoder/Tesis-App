import 'package:http/http.dart' as http;

class BaseAPI {
  final String baseURL;

  BaseAPI({required this.baseURL});

  Future<http.Response> makeGetRequest(String endpointUrl) async {
    var url = Uri.http(baseURL, endpointUrl);
    final response = await http.get(url);
    return response;
  }
}
