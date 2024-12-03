import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tesis_app/shared/services/base_api.dart';

import '../../bus/models/bus.dart';

class BusLocationAPI extends BaseAPI {
  static final BusLocationAPI _instance = BusLocationAPI._internal();

  BusLocationAPI._internal() : super(baseURL: "100.93.192.51:8000");

  factory BusLocationAPI() {
    return _instance;
  }

  Future<List<BusModel>?> getBusesFromRoute(int routeId, int companyId,
      double userLatitude, double userLongitude) async {
    final Map<String, String> queryParameters = <String, String>{
      'company_id': companyId.toString(),
      'route_id': routeId.toString(),
      'latitude': userLatitude.toString(),
      'longitude': userLongitude.toString(),
      'delay_in_min': "1",
      'max_distance_in_km': "10",
    };
    Map<String, String> headers = {
      'accept': 'application/json',
    };
    String endpointUrl = "bus-location/get-nearest-buses-from-user/";
    var url = Uri.http(baseURL, endpointUrl, queryParameters);
    final response = await http.get(url, headers: headers);
    if (response.statusCode != 200) {
      return null;
    }
    final responseBody = jsonDecode(response.body);
    List<BusModel> buses = (responseBody as List)
        .map((json) => BusModel(
              plate: json["plate"],
              busIdentifier: json["bus_identifier"],
              companyId: companyId,
              routeId: routeId,
              latitude: json["latitude"],
              longitude: json["longitude"],
              stopName: json["stop_name"],
              timeStamp: DateTime.parse(json["timestamp"]),
              distanceFromUser: json["distance_from_user"],
              speedInKmPerHr: json["speed_in_km_per_hr"],
              arrivalTimeInMin: json["arrival_time_in_min"],
            ))
        .toList();
    return buses;
  }
}
