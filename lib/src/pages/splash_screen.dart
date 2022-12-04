import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:muslim/config/app_config.dart' as config;
import 'package:muslim/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //Your animation controller
  AnimationController? _controller;
  late Animation<double> _animation;

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    // print("NAv");
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      // Navigator.of(context).pushReplacementNamed('/HomePage');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    //Implement animation here
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller!);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    // _animation.status.
    // _animation.removeListener(() { });
    super.dispose();
  }

//
  @override
  Widget build(BuildContext context) {
    _controller!.forward();
    return Stack(
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
        Hero(
          tag: "heroLogo2",
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                //Use your animation here
                opacity: _animation,
                child: Container(
                  width: config.App(context).appWidth(50),
                  height: config.App(context).appWidth(50),
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: AssetImage('assets/images/screen-0.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    border: Border.all(
                      color: Colors.white,
                      width: 4.0,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Educational',
                    style: TextStyle(
                        letterSpacing: 2,
                        decoration: TextDecoration.none,
                        fontSize: 50,
                        color: Colors.black87,
                        fontFamily: "Bubbleboddy"),
                  ),
                  Text(
                    'Memory Game',
                    style: TextStyle(
                        letterSpacing: 2,
                        decoration: TextDecoration.none,
                        fontSize: 40,
                        color: Colors.white,
                        fontFamily: "Bubbleboddy"),
                  ),
                ],
              ),

              // ColorLoader5(
              //   dotOneColor:  Color(0xffEAA9C7),
              // ),
            ],
          )),
        ),
      ],
    );
  }
}
