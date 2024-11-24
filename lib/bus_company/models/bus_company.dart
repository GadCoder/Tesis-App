import 'package:tesis_app/bus_route/models/bus_route.dart';

class BusCompanyModel {
  int id;
  String name;
  List<BusRouteModel> routes;

  BusCompanyModel({required this.name, required this.id, required this.routes});

  factory BusCompanyModel.fromJson(Map<String, dynamic> json) {
    return BusCompanyModel(
        name: json["name"],
        id: json["id"],
        routes: (json["routes"] as List)
            .map((route) => BusRouteModel.fromJson(route))
            .toList());
  }
}
