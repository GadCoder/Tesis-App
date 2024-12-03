import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../bus/models/bus.dart';
import '../../bus_company/models/bus_company.dart';
import '../../bus_route/models/bus_route.dart';
import 'base_api.dart';

class AppAPI extends BaseAPI {
  static final AppAPI _instance = AppAPI._internal();

  AppAPI._internal() : super(baseURL: "100.93.192.51:8001");

  factory AppAPI() {
    return _instance;
  }

  Future<List<BusRouteModel>?> getBusesRoutes() async {
    final response = await super.makeGetRequest("bus-route/get_all/");
    print(response.statusCode);
    if (response.statusCode != 200) {
      return null;
    }
    final responseBody = jsonDecode(response.body);

    List<BusRouteModel> routes = (responseBody as List)
        .map((json) => BusRouteModel.fromJson(json))
        .toList();

    return routes;
  }

  Future<List<BusCompanyModel>?> getBusesCompanies() async {
    final response = await makeGetRequest("bus-company/get-all");
    print(response.statusCode);
    if (response.statusCode != 200) {
      return null;
    }
    final responseBody = jsonDecode(response.body);
    List<BusCompanyModel> companies = (responseBody as List)
        .map((json) => BusCompanyModel.fromJson(json))
        .toList();

    return companies;
  }

  Future<List<BusModel>?> getBusesFromRoute(int routeId) async {
    final Map<String, String> queryParameters = <String, String>{
      'route_id': routeId.toString(),
    };
    Map<String, String> headers = {
      'accept': 'application/json',
    };
    const endpointUrl = "bus-route/get-buses-from-route";
    var url = Uri.http(baseURL, endpointUrl, queryParameters);
    final response = await http.get(url, headers: headers);
    if (response.statusCode != 200) {
      return null;
    }
    final responseBody = jsonDecode(response.body);

    List<BusModel> buses =
        (responseBody as List).map((json) => BusModel.fromJson(json)).toList();

    return buses;
  }
}
