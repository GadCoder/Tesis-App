import 'dart:convert';

import 'package:flutter/material.dart';

class FloatingDataCard extends StatefulWidget {
  const FloatingDataCard(
      {super.key, required this.companyName, required this.routeName});

  final String? companyName;
  final String? routeName;

  @override
  State<FloatingDataCard> createState() => _FloatingDataCardState();
}

class _FloatingDataCardState extends State<FloatingDataCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Column(
              children: [
                createTextToShow(),
              ],
            ),
          )),
    );
  }

  Widget createTextToShow() {
    if (widget.companyName == null && widget.routeName == null) {
      return const Text("No se ha seleccionado una empresa o ruta",
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center);
    }
    String companyName = utf8.decode(widget.companyName!.runes.toList());
    String routeName = utf8.decode(widget.routeName!.runes.toList());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Empresa: ",
              style: TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
            Text(
              "Ruta: ",
              style: TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Column(
          children: [
            Text(companyName),
            Text(routeName),
          ],
        )
      ],
    );
  }
}
