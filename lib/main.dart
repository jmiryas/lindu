import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';
import 'constants/constants.dart';
import '../screens/home_screen.dart';
import '../models/earthquake_model.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case gempaTerbaruTask:
        var result = await http.get(Uri.parse(gempaTerbaruAPI));

        var resultJson = json.decode(result.body);

        EarthquakeModel earthquakeResult =
            EarthquakeModel.fromJson(resultJson["Infogempa"]["gempa"]);

        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (!prefs.containsKey(prefsEarthquake) ||
            isNewEarthquake(prefs, earthquakeResult)) {
          displayNotification(earthquakeResult.magnitude,
              "${earthquakeResult.wilayah} pada ${earthquakeResult.tanggal}, ${earthquakeResult.jam}");
        }

        prefs.setString(
          prefsEarthquake,
          jsonEncode(
            earthquakeResult.toJson(),
          ),
        );

        break;
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  await Workmanager().registerPeriodicTask(
    "task-identifier",
    gempaTerbaruTask,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Lindu",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
