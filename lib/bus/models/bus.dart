class BusModel {
  String plate;
  String busIdentifier;
  int companyId;
  int routeId;
  double latitude;
  double longitude;
  String? stopName;
  DateTime timeStamp;
  double distanceFromUser;
  double speedInKmPerHr;
  double arrivalTimeInMin;

  BusModel({
    required this.plate,
    required this.busIdentifier,
    required this.companyId,
    required this.routeId,
    required this.latitude,
    required this.longitude,
    required this.stopName,
    required this.timeStamp,
    required this.distanceFromUser,
    required this.speedInKmPerHr,
    required this.arrivalTimeInMin,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      plate: json["plate"],
      busIdentifier: json["bus_identifier"],
      companyId: json["company_id"],
      routeId: json["route_id"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      stopName: json["stop_name"],
      timeStamp: DateTime.parse(json["time_stamp"]),
      distanceFromUser: json["distance_from_user"],
      speedInKmPerHr: json["speed_in_km_per_hr"],
      arrivalTimeInMin: json["arrival_time_in_min"],
    );
  }
}
