class BusModel {
  String plate;
  String busIdentifier;
  int companyId;
  int routeId;

  BusModel(
      {required this.plate,
      required this.busIdentifier,
      required this.companyId,
      required this.routeId});

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
        plate: json["plate"],
        busIdentifier: json["bus_identifier"],
        companyId: json["company_id"],
        routeId: json["route_id"]);
  }
}
