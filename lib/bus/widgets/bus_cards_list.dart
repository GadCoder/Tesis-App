import 'package:flutter/cupertino.dart';
import 'package:tesis_app/bus/models/bus.dart';

import 'package:tesis_app/bus/widgets/bus_card.dart';

import '../../shared/services/app_api.dart';

class BusCardsList extends StatefulWidget {
  const BusCardsList(
      {super.key,
      required this.scrollController,
      required this.buses,
      required this.companyName,
      required this.routeName});

  final ScrollController scrollController;
  final String? companyName;
  final String? routeName;
  final List<BusModel>? buses;

  @override
  State<BusCardsList> createState() => _BusCardsListState();
}

class _BusCardsListState extends State<BusCardsList> {
  final AppAPI api = AppAPI();

  @override
  Widget build(BuildContext context) {
    return widget.companyName == null || widget.routeName == null
        ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Text(
              "Selecciona una empresa y ruta de buses en el menú lateral",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ))
        : widget.buses!.isEmpty
            ? Text(
                "No se encontraron buses para la empresa ${widget.companyName} - ruta ${widget.routeName}")
            : buildBusCardList();
  }

  Widget buildBusCardList() {
    // Check if buses is null or empty before building the list
    if (widget.buses?.isEmpty ?? true) {
      return Center(
        child: Text(
            'No se tienen buses disponibles para la empresa ${widget.companyName} - ruta ${widget.routeName}'),
      );
    }

    return ListView.builder(
      controller: widget.scrollController,
      itemCount: widget.buses?.length ?? 0,
      // Safely get the length or default to 0
      itemBuilder: (context, index) {
        final item = widget.buses?[index];

        // Use null check on 'item' before passing it to buildItemWidget
        if (item != null) {
          return buildItemWidget(item);
        } else {
          return const SizedBox.shrink(); // Return an empty widget if 'item' is null
        }
      },
    );
  }

  // Method to create a single widget from the object
  Widget buildItemWidget(BusModel bus) {
    return Column(children: [
      const SizedBox(
        width: 15,
        height: 15,
      ),
      BusCard(
        busInfo: bus,
        companyName: widget.companyName!,
        routeName: widget.routeName!,
      )
    ]);
  }
}
