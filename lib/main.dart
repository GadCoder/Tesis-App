import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tesis_app/bus/models/bus.dart';
import 'package:tesis_app/bus/services/bus.dart';
import 'package:tesis_app/bus/widgets/bus_cards_list.dart';
import 'package:tesis_app/bus_company/models/bus_company.dart';
import 'package:tesis_app/bus_company/screens/picker.dart';
import 'package:tesis_app/bus_route/models/bus_route.dart';
import 'package:tesis_app/map/widgets/map.dart';
import 'package:tesis_app/bus/widgets/bus_cards_list.dart';
import 'package:tesis_app/shared/widgets/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tesis-App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tesis-App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BusCompanyModel? busCompany;
  BusRouteModel? busRoute;
  List<BusModel>? buses;
  BusAPI busApi = BusAPI();

  @override
  Widget build(BuildContext context) {
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: AppDrawer(
        setBusCompany: setBusCompany,
        setRoute: setRoute,
      ),
      body: SlidingUpPanel(
        minHeight: 160,
        panelBuilder: (ScrollController sc) => BusCardsList(
            scrollController: sc,
            buses: buses,
            companyName: busCompany?.name,
            routeName: busRoute?.name),
        body: Stack(children: [
          Map(),
          Positioned(
              top: 40,
              left: 20,
              child: Builder(builder: (BuildContext context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu));
              }))
        ]),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void setBusCompany(BusCompanyModel busCompany) {
    setState(() {
      this.busCompany = busCompany;
    });
  }

  void setRoute(BusRouteModel busRoute) {
    setState(() {
      this.busRoute = busRoute;
    });
    getBuses(busRoute.id);
  }

  Future<void> getBuses(int? routeId) async {
    if (busCompany == null || busRoute == null) {
      return;
    }
    Future<List<BusModel>?> result = busApi.getBusesFromRoute(busRoute!.id);
    List<BusModel>? buses = await result;
    print(buses);
    setState(() {
      this.buses = buses ?? [];
    });
  }
}
