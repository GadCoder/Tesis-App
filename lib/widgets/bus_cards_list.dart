import 'package:flutter/cupertino.dart';

import 'package:tesis_app/widgets/bus_card.dart';

Widget busCardsList(ScrollController sc) {
  return ListView.builder(
      controller: sc,
      itemCount: 5,
      itemBuilder: (BuildContext context, int i) {
        return Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: BusCard()),
            SizedBox(height: 20)
          ],
        );
      });
}
