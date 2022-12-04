import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:muslim/homepage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class ConfigOneSignal {
  // static final String baseUrl = "http://school.ixmedia.tech/";
  static final String oneSignalAppID = "489c07b5-ca00-4218-bb1b-0002756f81e6";


  static void handleClickNotification(BuildContext context) {
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
      try {
        // var id = await result.notification.payload.additionalData["data_id"];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e, stacktrace) {
        log(e.toString());
      }
    });
  }

}
