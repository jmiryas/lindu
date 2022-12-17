import 'package:flutter/material.dart';
import 'package:lindu/constants/constants.dart';
import 'package:lindu/widgets/container_background_widget.dart';
import 'package:lindu/widgets/earthquake_card_item_widget.dart';
import 'package:lindu/widgets/earthquake_card_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double height = MediaQuery.of(context).size.height - statusBarHeight;

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Stack(
        children: [
          ContainerBackgroundWidget(
            height: 0.4 * height,
            color: containerBackgroundColor,
          ),
          EarthquakeCardWidget(
            height: 0.8 * height,
            width: width,
            margin: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 0.1 * height,
            ),
            widget: Column(
              children: [
                EarthquakeCardItemWidget(
                  width: width,
                  height: 0.7 * height,
                  color: Colors.grey.shade100.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  widget: ListView(
                    children: [
                      const ListTile(
                        title: Text("Tentang Aplikasi"),
                        subtitle: Text(
                          "Aplikasi ini dibuat dengan menggunakan Flutter untuk menampilkan informasi mengenai gempa terbaru dan gempa dengan magnitude 5+.",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const ListTile(
                        title: Text("Author"),
                        subtitle: Text(
                          "Rizky Ramadhan",
                        ),
                      ),
                      const ListTile(
                        title: Text("Sumber Data"),
                        subtitle: Text(
                          "Data yang digunakan aplikasi ini berasal dari website Data Terbuka BMKG (https://data.bmkg.go.id/).",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: 0.45 * width,
                        height: 0.45 * width,
                        child: Image.asset(
                          "assets/images/bmkg.png",
                        ),
                      ),
                    ],
                  ),
                ),
                EarthquakeCardItemWidget(
                  width: width,
                  height: 0.1 * height,
                  color: const Color(containerBackgroundColor),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  widget: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Tentang Kami",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            fontSize: 0.3 * (0.1 * height),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
