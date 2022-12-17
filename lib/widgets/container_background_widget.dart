import 'package:flutter/material.dart';

class ContainerBackgroundWidget extends StatelessWidget {
  final double height;
  final int color;

  const ContainerBackgroundWidget({
    Key? key,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(color),
      height: height,
    );
  }
}
