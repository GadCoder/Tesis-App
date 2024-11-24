import 'dart:convert';
import 'package:tesis_app/bus_route/models/bus_route.dart';

import '../../shared/services/api_base.dart';

class BusRouteAPI extends ApiBase {
  Future<List<BusRouteModel>?> getBusesRoutes() async {
    final response = await makeGetRequest("bus-route/get_all/");
    if (response.statusCode != 200) {
      return null;
    }
    final responseBody = jsonDecode(response.body);

    List<BusRouteModel> routes = (responseBody as List)
        .map((json) => BusRouteModel.fromJson(json))
        .toList();

    return routes;
  }
}
