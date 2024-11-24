import 'dart:convert';

import '../../shared/services/api_base.dart';

import '../models/bus_company.dart';

class BusCompanyAPI extends ApiBase {
  Future<List<BusCompanyModel>?> getBusesCompanies() async {
    final response = await makeGetRequest("bus-company/get-all");
    print(response.statusCode);
    if (response.statusCode != 200) {
      return null;
    }
    final responseBody = jsonDecode(response.body);
    print(responseBody);
    List<BusCompanyModel> companies = (responseBody as List)
        .map((json) => BusCompanyModel.fromJson(json))
        .toList();

    return companies;
  }
}
