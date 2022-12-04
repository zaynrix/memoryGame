// //@dart=2.6
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muslim/config_onesignal.dart';
import 'package:muslim/dummy_data/lang_dummy.dart';
import 'package:muslim/homepage.dart';
import 'package:muslim/route_generator.dart';
import 'package:muslim/src/elements/BlockButtonWidget.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart' as SH;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {

    MobileAds.instance.initialize();

    return true;
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {

    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SH.SharedPreferences sharedPreferences;
   String ?prefLanguage ;
  late String notifyContent;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  initLang() async {
    print("init languages");
    sharedPreferences = await SH.SharedPreferences.getInstance();
    prefLanguage = sharedPreferences.getString('language')!;
    if (prefLanguage == '""') {
      prefLanguage = 'en_US';
      setState(() {});
      sharedPreferences.setString('language', 'en_US');
    }
  }

  @override
  void initState() {
    initLang();

    OneSignal.shared.setNotificationOpenedHandler(
        _handleNotificationOpened); // OneSignal.shared.init("your_app_id_here");
    super.initState();
    configOneSignal();
  }

  void _handleNotificationOpened(OSNotificationOpenedResult result) {
    print('[notification_service - _handleNotificationOpened()');
    print(
        "Opened notification: ${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");

    // Since the only thing we can get current are new Alerts -- go to the Alert screen
    // navigatorKey.currentState!.pushNamed('/debug',);
    navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  void configOneSignal() async {
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    // await OneSignal.shared.init(ConfigOneSignal.oneSignalAppID);
    OneSignal.shared.setAppId(ConfigOneSignal.oneSignalAppID);

    // await OneSignal.shared.setLogLevel (OneSignal.shared.logl .oneSignalAppID);
    //show notification content
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      setState(() {
        notifyContent = event.jsonRepresentation().replaceAll('\\n', '\n');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () {},
      translations: WorldLanguage(),
      locale: prefLanguage == null
          ? Locale('en', 'US')
          : Locale(prefLanguage!.split('_')[0], prefLanguage!.split('_')[1]),
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomError(errorDetails: errorDetails);
        };
        return widget!;
      },

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ar', ''),
      ],

      // locale: Locale('ar', 'AE'),
      title: 'Memory Game',
      theme: ThemeData(
        fontFamily: 'Bubbleboddy',
        primarySwatch: Colors.grey,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: '/Splash',
      navigatorKey: navigatorKey,

      // home: Home(),
    );
  }
}
