import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tesis_app/map/services/get_location.dart';

class Map extends StatefulWidget {
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  Position? userPosition;

  /*

  @override
  void initState() {
    super.initState();
    getUserPosition().then((response) {
      setState(() {
        userPosition = response;
      });
    });
  }
   */

  @override
  Widget build(BuildContext context) {
    /*

    if (userPosition == null) {
      return const Center(
          child: CircularProgressIndicator()); // Loading indicator
    }
     */
    return FlutterMap(
      mapController: MapController(),
      options: const MapOptions(
          maxZoom: 18.5,
          initialZoom: 16.5,
          initialCenter:
              // LatLng(userPosition!.latitude, userPosition!.longitude)),
              LatLng(-12.059950896379561, -77.07892930074227)),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          // Plenty of other options available!
        ),
      ],
    );
  }

  Future<Position> getUserPosition() async {
    Position position = await determinePosition();
    return position;
  }
}
