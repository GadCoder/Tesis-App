class BusRouteModel {
  int id;
  String name;
  int companyId;

  BusRouteModel(
      {required this.id, required this.name, required this.companyId});

  factory BusRouteModel.fromJson(Map<String, dynamic> json) {
    return BusRouteModel(
        id: json["id"], name: json["name"], companyId: json["company_id"]);
  }
}
