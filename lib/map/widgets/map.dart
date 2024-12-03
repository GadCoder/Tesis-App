import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tesis_app/map/services/get_location.dart';
import '../../bus/models/bus.dart';

class Map extends StatefulWidget {
  final List<BusModel> buses;
  final List<Marker> markers;

  const Map({super.key, required this.buses, required this.markers});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final LatLng userPosition = const LatLng(-12.0599382, -77.0371681);
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: userPosition,
        zoom: 15.0,
      ),
      markers: Set<Marker>.of(widget.markers),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> getUserPosition() async {
    Position position = await determinePosition();
    return position;
  }
}
