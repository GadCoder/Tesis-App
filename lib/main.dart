import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tesis_app/bus/models/bus.dart';
import 'package:tesis_app/bus/widgets/bus_cards_list.dart';
import 'package:tesis_app/bus_company/models/bus_company.dart';
import 'package:tesis_app/bus_route/models/bus_route.dart';
import 'package:tesis_app/map/widgets/map.dart';
import 'package:tesis_app/shared/services/app_api.dart';
import 'package:tesis_app/shared/services/bus_location_api.dart';
import 'package:tesis_app/shared/widgets/drawer.dart';
import 'package:tesis_app/shared/widgets/floating_data_card.dart';

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
  BusCompanyModel? selectedBusCompany;
  BusRouteModel? selectedBusRoute;
  List<BusModel>? buses = [];
  late List<Marker> markers = [];

  AppAPI busApi = AppAPI();
  BusLocationAPI busLocationApi = BusLocationAPI();
  Timer? _timer;
  late BitmapDescriptor busCustomIcon;

  @override
  void initState() {
    super.initState();
    _startTimer();
    createBusCustomIcon();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (selectedBusCompany != null && selectedBusRoute != null) {
        getBuses();
        createMapMarkers();
      }
      createUserMarker();
    });
  }

  @override
  Widget build(BuildContext context) {
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: AppDrawer(
        setBusCompany: setBusCompany,
        setRoute: setRoute,
      ),
      body: SlidingUpPanel(
        backdropEnabled: true,
        backdropOpacity: 0.2,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        minHeight: 160,
        panelBuilder: (ScrollController sc) => BusCardsList(
            scrollController: sc,
            buses: buses,
            companyName: selectedBusCompany?.name,
            routeName: selectedBusRoute?.name),
        body: Stack(children: [
          Map(buses: buses ?? [], markers: markers),
          Positioned(
              top: 40,
              left: 20,
              child: Builder(builder: (BuildContext context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu));
              })),
          Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingDataCard(
                      companyName: selectedBusCompany?.name,
                      routeName: selectedBusRoute?.name)
                ],
              ))
        ]),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void setBusCompany(BusCompanyModel busCompany) {
    setState(() {
      selectedBusCompany = busCompany;
    });
  }

  void setRoute(BusRouteModel busRoute) {
    setState(() {
      selectedBusRoute = busRoute;
    });
    getBuses();
  }

  Future<void> getBuses() async {
    if (selectedBusCompany == null || selectedBusRoute == null) {
      return;
    }
    Future<List<BusModel>?> result = busLocationApi.getBusesFromRoute(
        selectedBusRoute!.id, selectedBusCompany!.id, -12.0599382, -77.0371681);

    List<BusModel>? buses = await result;
    setState(() {
      this.buses = buses ?? [];
    });
  }

  void createBusCustomIcon() {
    BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      "assets/images/bus_icon.png",
    ).then((icon) {
      setState(() {
        busCustomIcon = icon;
      });
    });
  }

  void createMapMarkers() {
    setState(() {
      markers.clear();
      for (BusModel bus in buses!) {
        markers.add(Marker(
          markerId: MarkerId(bus.plate),
          position: LatLng(bus.latitude, bus.longitude),
          infoWindow: InfoWindow(
              title: bus.plate,
              snippet: "A ${bus.arrivalTimeInMin.toInt()} min."),
          icon: busCustomIcon,
        ));
      }
    });
  }

  void createUserMarker() {
    BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      "assets/images/baby_yoda.png",
    ).then((icon) {
      setState(() {
        markers.add(Marker(
          markerId: const MarkerId("user"),
          position: const LatLng(-12.0599382, -77.0371681),
          infoWindow: const InfoWindow(title: "User", snippet: ""),
          icon: icon,
        ));
      });
    });
  }
}
