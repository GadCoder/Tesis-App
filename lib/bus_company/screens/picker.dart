import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tesis_app/bus_company/models/bus_company.dart';
import 'package:tesis_app/bus_company/services/bus_company.dart';
import 'package:tesis_app/bus_route/models/bus_route.dart';

class BusCompanyPicker extends StatefulWidget {
  const BusCompanyPicker(
      {super.key, required this.setBusCompany, required this.setRoute});

  final Function(BusCompanyModel) setBusCompany;
  final Function(BusRouteModel) setRoute;

  @override
  State<BusCompanyPicker> createState() => _BusCompanyPickerState();
}

class _BusCompanyPickerState extends State<BusCompanyPicker> {
  List<BusCompanyModel>? companies;
  List<BusRouteModel>? routes;
  final BusCompanyAPI api = BusCompanyAPI();
  int? selectedCompanyId;
  int? selectedRouteId;

  @override
  void initState() {
    super.initState();
    getCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text("Selector de empresa de transporte y ruta"),
            automaticallyImplyLeading: true),
        body: Center(
          child: companies == null
              ? const Center(child: CircularProgressIndicator())
              : companies!.isEmpty
                  ? const Text(
                      "No se pudieron encontrar empresas de transporte")
                  : SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                                "Elije una empresa de transporte y ruta"),
                            DropdownButton(
                              hint: const Text("Selecciona una empresa"),
                              value: selectedCompanyId,
                              items: companies?.map<DropdownMenuItem<int>>(
                                  (BusCompanyModel company) {
                                return DropdownMenuItem<int>(
                                    value: company.id,
                                    child: Text(utf8
                                        .decode(company.name.runes.toList())));
                              }).toList(),
                              onChanged: (int? newValue) {
                                setSelectedCompany(newValue!);
                                setState(() {
                                  selectedCompanyId = newValue;
                                });
                              },
                            ),
                            DropdownButton(
                              hint: const Text("Selecciona una ruta "),
                              value: selectedRouteId,
                              items: routes?.map<DropdownMenuItem<int>>(
                                  (BusRouteModel route) {
                                return DropdownMenuItem<int>(
                                    value: route.id,
                                    child: Text(utf8
                                        .decode(route.name.runes.toList())));
                              }).toList(),
                              onChanged: selectedCompanyId == null
                                  ? null
                                  : (int? newValue) {
                                      setSelectedRoute(newValue!);
                                      setState(() {
                                        selectedRouteId = newValue;
                                      });
                                    },
                            ),
                          ]),
                    ),
        ));
  }

  Future<void> getCompanies() async {
    Future<List<BusCompanyModel>?> result = api.getBusesCompanies();
    List<BusCompanyModel>? companies = await result;
    setState(() {
      this.companies = companies ?? [];
    });
  }

  void setSelectedCompany(int newValue) {
    for (final company in companies!) {
      if (company.id == newValue) {
        widget.setBusCompany(company);
        setState(() {
          routes = company.routes;
        });
      }
    }
  }

  void setSelectedRoute(int newValue) {
    for (final route in routes!) {
      if (route.id == newValue) {
        widget.setRoute(route);
      }
    }
  }
}
