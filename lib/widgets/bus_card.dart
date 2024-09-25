import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesis_app/models/busInfo.dart';

class BusCard extends StatefulWidget {
  @override
  State<BusCard> createState() => _BusCardState();
}

class _BusCardState extends State<BusCard> {
  BusInfo busInfo = BusInfo("H3LL0-THER3", "El Rápido", "42", 5, 10);

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
                offset: Offset(0, 2),
              ),
            ]),
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    busInfo.plate,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Empresa: ${busInfo.companyName}"),
                    Text("Distancia: ${busInfo.distanceFromUserInKm} km.")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ruta: ${busInfo.route}"),
                    Text(
                        "Tiempo de llegada: ${busInfo.estimatedTimeOfArrivalInMin} min."),
                  ],
                )
              ],
            )));
  }
}
