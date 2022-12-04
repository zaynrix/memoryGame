import 'package:flutter/material.dart';
import 'package:muslim/config/app_config.dart' as config;

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/images/splash.png",
              fit: BoxFit.fill,
              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(100),
            ),
            Container(
              color: Color(0xffFEC200).withOpacity(0.3),
              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(100),
            ),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/succes.gif",
                    width: config.App(context).appWidth(100),
                    height: config.App(context).appWidth(100),
                  ),
                  GestureDetector(
                    onTap: () {
                     Navigator.pop(context);
                      // });
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        "Replay",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
