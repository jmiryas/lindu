import 'package:flutter/material.dart';

class EarthquakeCardWidget extends StatelessWidget {
  final double height;
  final double width;
  final Widget widget;
  final EdgeInsets margin;

  const EarthquakeCardWidget({
    super.key,
    required this.height,
    required this.width,
    required this.widget,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        // implement shadow effect
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(3, 3),
            spreadRadius: 0.1,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: widget,
    );
  }
}
