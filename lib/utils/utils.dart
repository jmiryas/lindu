import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../constants/constants.dart';
import '../models/earthquake_model.dart';

// Menampilkan informasi gempa melalui notifikasi

void displayNotification(
  String magnitude,
  String description,
) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'Earthquake-1',
    'Earthquake',
    channelDescription: 'Latest earthquake',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    styleInformation: BigTextStyleInformation(""),
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    "Gempa Magnitude $magnitude",
    description,
    notificationDetails,
    payload: gempaTerbaruTask,
  );
}

// Mengecek apakah gempa yang berasal dari API
// merupakan data baru atau tidak di shared preferences

bool isNewEarthquake(
    SharedPreferences prefs, EarthquakeModel fetchedEartquake) {
  if (prefs.containsKey(prefsEarthquake)) {
    var prefsDateTime = DateTime.parse(
        jsonDecode(prefs.getString(prefsEarthquake)!)["DateTime"]);

    var comparationResult = prefsDateTime.isBefore(fetchedEartquake.dateTime!);

    return comparationResult;
  }

  return false;
}
