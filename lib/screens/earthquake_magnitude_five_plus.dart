import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/earthquake_model.dart';
import '../widgets/earthquake_card_widget.dart';
import '../widgets/earthquake_gird_widget.dart';
import '../widgets/container_background_widget.dart';
import '../widgets/earthquake_card_item_widget.dart';

class EarthquakeMagnitudeFivePlusScreen extends StatefulWidget {
  const EarthquakeMagnitudeFivePlusScreen({Key? key}) : super(key: key);

  @override
  State<EarthquakeMagnitudeFivePlusScreen> createState() =>
      _EarthquakeMagnitudeFivePlusScreenState();
}

class _EarthquakeMagnitudeFivePlusScreenState
    extends State<EarthquakeMagnitudeFivePlusScreen> {
  late Future<List<EarthquakeModel>> currentEarthquakes;

  Future<List<EarthquakeModel>> fetchLatestEarthquakes() async {
    final response = await http.get(Uri.parse(gempaMagnitude5Plus));

    if (response.statusCode == 200) {
      var earthquakesJson = jsonDecode(response.body)["Infogempa"]["gempa"];

      List<EarthquakeModel> earthquakesResult = [];

      earthquakesJson.forEach((item) {
        earthquakesResult.add(EarthquakeModel.fromJson(item));
      });

      return earthquakesResult;
    } else {
      throw Exception('Maaf, terjadi error');
    }
  }

  @override
  void initState() {
    super.initState();

    currentEarthquakes = fetchLatestEarthquakes();
  }

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
            widget: FutureBuilder(
              future: fetchLatestEarthquakes(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      EarthquakeCardItemWidget(
                        width: width,
                        height: 0.7 * height,
                        color: Colors.grey.shade100.withOpacity(0.9),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                        widget: EarthquakeGridWidget(
                          earthquakes: snapshot.data!,
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
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Gempa Magnitude 5+",
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
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Maaf, terjadi error"),
                  );
                }

                return const Center(
                  child: SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
