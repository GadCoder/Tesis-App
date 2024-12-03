import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tesis_app/bus_company/models/bus_company.dart';
import 'package:tesis_app/bus_route/models/bus_route.dart';

import '../../shared/services/app_api.dart';

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
  final AppAPI api = AppAPI();
  int? selectedCompanyId;
  int? selectedRouteId;
  String? selectedCompanyName;
  String? selectedRouteName;

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
            title: const Text("Elige una empresa y ruta"),
            automaticallyImplyLeading: true),
        body: Center(
            child: companies == null
                ? const Center(child: CircularProgressIndicator())
                : companies!.isEmpty
                    ? const Text(
                        "No se pudieron encontrar empresas de transporte")
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Elige una empresa de transporte",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    DropdownButton(
                                      hint:
                                          const Text("Selecciona una empresa"),
                                      value: selectedCompanyId,
                                      items: companies
                                          ?.map<DropdownMenuItem<int>>(
                                              (BusCompanyModel company) {
                                        return DropdownMenuItem<int>(
                                            value: company.id,
                                            child: Text(utf8.decode(
                                                company.name.runes.toList())));
                                      }).toList(),
                                      onChanged: (int? newValue) {
                                        setSelectedCompany(newValue!);
                                        setState(() {
                                          selectedCompanyId = newValue;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 80),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(
                                        selectedCompanyName == null
                                            ? "Elige una ruta "
                                            : "Elige una ruta de la empresa $selectedCompanyName",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                        ),
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    DropdownButton(
                                      hint: const Text("Selecciona una ruta"),
                                      value: selectedRouteId,
                                      items: routes?.map<DropdownMenuItem<int>>(
                                          (BusRouteModel route) {
                                        return DropdownMenuItem<int>(
                                            value: route.id,
                                            child: Text(utf8.decode(
                                                route.name.runes.toList())));
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
                                  ],
                                )
                              ]),
                          const SizedBox(height: 80),
                          ElevatedButton(
                              onPressed: () {
                                getBackHome(context);
                              },
                              child: const Text("Volver a inicio"))
                        ],
                      )));
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
          selectedCompanyName = utf8.decode(company.name.runes.toList());
        });
      }
    }
  }

  void setSelectedRoute(int newValue) {
    for (final route in routes!) {
      if (route.id == newValue) {
        widget.setRoute(route);
        setState(() {
          selectedRouteName = utf8.decode(route.name.runes.toList());
        });
      }
    }
    showSucessToast(
        "Se escogio la ruta $selectedRouteName de la empresa $selectedCompanyName");
  }

  void getBackHome(BuildContext context) {
    if (selectedCompanyId == null) {
      showErrorToast("Por favor, selecciona una empresa de transporte");
      return;
    }
    if (selectedRouteId == null) {
      showErrorToast("Por favor, selecciona una ruta de transporte");
      return;
    }

    Navigator.pop(context);
  }

  void showSucessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
