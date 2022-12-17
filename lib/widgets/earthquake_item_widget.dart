import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../constants/constants.dart';
import '../models/earthquake_model.dart';

class EarthquakeItemWidget extends StatelessWidget {
  final EarthquakeModel earthquake;
  final double magnitude;
  final bool isMagnitudeMoreThan5;

  const EarthquakeItemWidget({
    super.key,
    required this.earthquake,
    required this.magnitude,
    required this.isMagnitudeMoreThan5,
  });

  @override
  Widget build(BuildContext context) {
    String shakemapUrl = getShakemap(earthquake.dateTime.toString());

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Card(
      color: Color(
        getEarthquakeColor(magnitude),
      ),
      child: ListTile(
        title: Text(
          "Gempa Magnitude $magnitude",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isMagnitudeMoreThan5 ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          "${earthquake.tanggal}, ${earthquake.jam}",
          style: TextStyle(
            color: isMagnitudeMoreThan5
                ? Colors.white.withOpacity(0.7)
                : Colors.black,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                height: height * 0.65,
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
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: shakemapUrl,
                          placeholder: (context, url) => const SizedBox(
                            height: 50.0,
                            child: Center(
                              child: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            height: 50.0,
                            child: Center(
                              child: Text("Maaf, shakemap tidak ditemukan"),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.waves,
                                    color: Color(containerBackgroundColor),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    earthquake.magnitude,
                                    style: TextStyle(
                                      fontSize: 0.05 * width,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text("Magnitude",
                                      style: TextStyle(fontSize: 0.04 * width)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.arrow_downward_rounded,
                                    color: Color(containerBackgroundColor),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    earthquake.kedalaman,
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
                                    style: TextStyle(fontSize: 0.04 * width),
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
                                "${earthquake.tanggal} - ${earthquake.jam}",
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
                                "${earthquake.lintang} - ${earthquake.bujur}",
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
                                earthquake.wilayah,
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
                                earthquake.potensi,
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
          icon: Icon(
            Icons.arrow_forward_ios,
            color: isMagnitudeMoreThan5 ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
