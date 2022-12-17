import 'package:flutter/material.dart';

// Task / Workmanager

const gempaTerbaruTask = "gempaTerbaruAPI";

// Shared preferences

const prefsEarthquake = "currentEarthquake";

// API

const String gempaTerbaruAPI =
    "https://data.bmkg.go.id/DataMKG/TEWS/autogempa.json";

const String gempaMagnitude5Plus =
    "https://data.bmkg.go.id/DataMKG/TEWS/gempaterkini.json";

const String shakemapAPI = "https://data.bmkg.go.id/DataMKG/TEWS/";

// Colors

const containerBackgroundColor = 0xFF227093;
const Color unselectedItemColor = Color.fromARGB(255, 142, 194, 218);

const Color scaffoldBgColor = Color.fromARGB(255, 235, 236, 243);

const earthquakeColor1 = 0xFFf5cd79;
const earthquakeColor2 = 0xFFf19066;
const earthquakeColor3 = 0xFFe15f41;
const earthquakeColor4 = 0xFFc44569;
const earthquakeColor5 = 0xFF303952;

int getEarthquakeColor(double magnitude) {
  if (magnitude >= 5.0 && magnitude < 6.0) {
    return earthquakeColor1;
  } else if (magnitude >= 6.0 && magnitude < 7.0) {
    return earthquakeColor2;
  } else if (magnitude >= 7.0 && magnitude < 8.0) {
    return earthquakeColor3;
  } else if (magnitude >= 8.0 && magnitude < 9.0) {
    return earthquakeColor4;
  } else {
    return earthquakeColor5;
  }
}
