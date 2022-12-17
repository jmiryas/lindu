import 'package:flutter/material.dart';

class EarthquakeCardItemWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;
  final Widget widget;

  const EarthquakeCardItemWidget({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: widget,
    );
  }
}
