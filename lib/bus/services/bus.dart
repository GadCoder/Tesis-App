import 'dart:convert';
import '../../shared/services/api_base.dart';
import 'package:http/http.dart' as http;

import '../models/bus.dart';

class BusAPI extends ApiBase {
  Future<List<BusModel>?> getBusesFromRoute(int routeId) async {
    final Map<String, String> queryParameters = <String, String>{
      'route_id': routeId.toString(),
    };
    Map<String, String> headers = {
      'accept': 'application/json',
    };
    const endpointUrl = "bus-route/get-buses-from-route";
    var url = Uri.http(ApiBase.baseURL, endpointUrl, queryParameters);
    final response = await http.get(url, headers: headers);
    print("STATUS CODE -> ${response.statusCode}");
    if (response.statusCode != 200) {
      return null;
    }
    final responseBody = jsonDecode(response.body);

    List<BusModel> buses =
        (responseBody as List).map((json) => BusModel.fromJson(json)).toList();

    return buses;
  }
}
