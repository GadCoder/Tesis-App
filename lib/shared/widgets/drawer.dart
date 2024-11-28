import 'package:flutter/material.dart';
import 'package:tesis_app/bus_company/models/bus_company.dart';
import 'package:tesis_app/bus_route/models/bus_route.dart';

import '../../bus_company/screens/picker.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer(
      {super.key, required this.setBusCompany, required this.setRoute});

  final Function(BusCompanyModel) setBusCompany;
  final Function(BusRouteModel) setRoute;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Tesis-App'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.directions_bus),
            title: const Text('Elegir empresa y ruta'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BusCompanyPicker(
                      setBusCompany: widget.setBusCompany,
                      setRoute: widget.setRoute)));
            },
          ),
        ],
      ),
    );
  }
}
