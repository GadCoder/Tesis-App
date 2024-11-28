import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tesis_app/bus/models/bus.dart';

class BusCard extends StatefulWidget {
  const BusCard(
      {super.key,
      required this.busInfo,
      required this.companyName,
      required this.routeName});

  final BusModel busInfo;
  final String companyName;
  final String routeName;

  @override
  State<BusCard> createState() => _BusCardState();
}

class _BusCardState extends State<BusCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 15,
                offset: const Offset(0, 2),
              ),
            ]),
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.busInfo.plate),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Empresa: ${utf8.decode(widget.companyName.runes.toList())}"),
                    Text(
                        "Distancia: ${widget.busInfo.distanceFromUser.toStringAsFixed(2)} km.")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ruta: ${widget.routeName}"),
                    const Text("Tiempo de llegada: ${15} min."),
                  ],
                )
              ],
            )));
  }
}
