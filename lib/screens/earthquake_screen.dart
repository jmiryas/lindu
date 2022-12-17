import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../constants/constants.dart';
import '../models/earthquake_model.dart';
import '../widgets/earthquake_card_widget.dart';
import '../widgets/earthquake_card_item_widget.dart';
import '../widgets/container_background_widget.dart';

class EarthquakeScreen extends StatefulWidget {
  const EarthquakeScreen({Key? key}) : super(key: key);

  @override
  State<EarthquakeScreen> createState() => _EarthquakeScreenState();
}

class _EarthquakeScreenState extends State<EarthquakeScreen> {
  late Future<EarthquakeModel> currentEarthquake;

  Future<EarthquakeModel> fetchLatestEarthquake() async {
    final response = await http.get(Uri.parse(gempaTerbaruAPI));

    if (response.statusCode == 200) {
      return EarthquakeModel.fromJson(
          jsonDecode(response.body)["Infogempa"]["gempa"]);
    } else {
      throw Exception("Maaf, terjadi error");
    }
  }

  @override
  void initState() {
    super.initState();

    currentEarthquake = fetchLatestEarthquake();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30.0;
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
              future: fetchLatestEarthquake(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          decoration: const BoxDecoration(
                            color: scaffoldBgColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView(
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.waves,
                                              color: Color(
                                                  containerBackgroundColor),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              snapshot.data!.magnitude,
                                              style: TextStyle(
                                                fontSize: 0.05 * width,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text("Magnitude",
                                                style: TextStyle(
                                                    fontSize: 0.04 * width)),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.arrow_downward_rounded,
                                              color: Color(
                                                  containerBackgroundColor),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              snapshot.data!.kedalaman,
                                              style: TextStyle(
                                                fontSize: 0.05 * width,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "Kedalaman",
                                              style: TextStyle(
                                                  fontSize: 0.04 * width),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: const Text("Tanggal"),
                                        subtitle: Text(
                                          "${snapshot.data!.tanggal} - ${snapshot.data!.jam}",
                                        ),
                                        trailing: const CircleAvatar(
                                          radius: 5.0,
                                          backgroundColor:
                                              Color(containerBackgroundColor),
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text("Koordinat"),
                                        subtitle: Text(
                                          "${snapshot.data!.lintang} - ${snapshot.data!.bujur}",
                                        ),
                                        trailing: const CircleAvatar(
                                          radius: 5.0,
                                          backgroundColor:
                                              Color(containerBackgroundColor),
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text("Wilayah"),
                                        subtitle: Text(
                                          snapshot.data!.wilayah,
                                        ),
                                        trailing: const CircleAvatar(
                                          radius: 5.0,
                                          backgroundColor:
                                              Color(containerBackgroundColor),
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text("Potensi"),
                                        subtitle: Text(
                                          snapshot.data!.potensi,
                                        ),
                                        trailing: const CircleAvatar(
                                          radius: 5.0,
                                          backgroundColor:
                                              Color(containerBackgroundColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        EarthquakeCardItemWidget(
                          width: width,
                          height: 0.7 * height,
                          color: Colors.grey.shade100.withOpacity(0.9),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          widget: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl:
                                  "$shakemapAPI${snapshot.data!.shakemap}",
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                  width: 25.0,
                                  height: 25.0,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Text("Maaf, shakemap tidak ditemukan"),
                              ),
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Gempa Terbaru",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2,
                                    fontSize: 0.3 * (0.1 * height),
                                    color: Colors.white,
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
