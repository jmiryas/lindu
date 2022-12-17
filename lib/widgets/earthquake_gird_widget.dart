import 'package:flutter/material.dart';

import '../models/earthquake_model.dart';
import '../widgets/earthquake_item_widget.dart';

class EarthquakeGridWidget extends StatelessWidget {
  final List<EarthquakeModel> earthquakes;

  const EarthquakeGridWidget({
    super.key,
    required this.earthquakes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: earthquakes.map((item) {
        var magnitude = double.parse(item.magnitude);

        bool isMagnitudeMoreThan5 = magnitude >= 7.0;

        return EarthquakeItemWidget(
          earthquake: item,
          magnitude: magnitude,
          isMagnitudeMoreThan5: isMagnitudeMoreThan5,
        );
      }).toList(),
    );
  }
}
