import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "dart:async";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tesis-App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  late Timer timer;
  late GoogleMapController mapController;

  double initialCenterLatitude = -12.056009751491201;
  double initialCenterLongitude = -77.08527524172905;

  final LatLng _center = const LatLng(-12.056009751491201, -77.08527524172905);

  late double busLatitude;
  late double busLongitude;
  int initialBusStop = 0;
  int currentBusStop = 0;

  late List<List<double>> busStops;
  late List<String> busStopsTittles;

  late String currentBusStopTittle;

  //HashMap<String, List<double>> busStops = HashMap<String, List<double>>();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    buildBusStops();
    busLatitude = busStops[0][0];
    busLongitude = busStops[0][1];
    currentBusStopTittle = busStopsTittles[0];
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App - Tesis'),
          elevation: 2,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.0,
          ),
          markers: {
            Marker(
                markerId: const MarkerId("Burrito"),
                position: LatLng(busLatitude, busLongitude),
                infoWindow: InfoWindow(title: currentBusStopTittle)),
          },
        ),
      ),
    );
  }

  void buildBusStops() {
    busStops = [
      [-12.059516492985944, -77.07966179884886], //puerta_dos
      [-12.057194481972388, -77.08026085564354], //puerta_tres
      [-12.055506135722492, -77.08194264375699], //clinica
      [-12.054182686914697, -77.08452392466317], //puerta_7
      [-12.05374385563598, -77.08552411225324], // fisi
      [-12.054825269340004, -77.08624114457085], //odonto
      [-12.05633904491605, -77.08513345408782], //rectorado
      [-12.059744446723668, -77.08447851434235], //gimnasio
      [-12.06016657896905, -77.08438381988303], //comedor
      [-12.06038425975368, -77.08085508594671] //industrial
    ];
    busStopsTittles = [
      "Puerta dos", //puerta_dos
      "Puerta tres", //puerta_tres
      "Clinica", //clinica
      "Puerta 7", //puerta_7
      "FISI", // fisi
      "Odontologia", //odonto
      "Rectorado", //rectorado
      "Gimnasio", //gimnasio
      "Comedor", //comedor
      "Industrial" //industrial
    ];
  }

  Future<void> startTimer() async {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      updateLocation();
    });
  }

  Future<void> updateLocation() async {
    List<double> currentBusCoordinates = busStops[currentBusStop];
    currentBusStopTittle = busStopsTittles[currentBusStop];
    setState(() {
      busLatitude = currentBusCoordinates[0];
      busLongitude = currentBusCoordinates[1];
    });
    bool isOnLastBusStop = currentBusStop == 9;
    if (isOnLastBusStop) {
      currentBusStop = 0;
    } else {
      currentBusStop++;
    }
  }
}
