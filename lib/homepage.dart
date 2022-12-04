import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:muslim/Helper/helper.dart';
import 'package:muslim/config/app_config.dart' as config;
import 'package:muslim/src/pages/catergory.dart';
import 'package:get/get.dart';

import 'data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetsAudioPlayer? _assetsAudioPlayer;

  void openPlayer() async {
    print("openPlayer");

    await _assetsAudioPlayer!.open(Audio('assets/songs/intro.mp3'));
  }

  void closePlayer() async {
    print("openPlayer");

    await _assetsAudioPlayer!.stop();
  }

  @override
  void initState() {
    _assetsAudioPlayer = AssetsAudioPlayer();

    openPlayer();
    _assetsAudioPlayer!.playOrPause();

    super.initState();
  }

  @override
  void dispose() {
    // _assetsAudioPlayer.stop();
    print('dispose');
    _assetsAudioPlayer = null;

    // _assetsAudioPlayer.stop();
    super.dispose();
    _assetsAudioPlayer!.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/splash.png",
            fit: BoxFit.cover,
            width: config.App(context).appWidth(100),
            height: config.App(context).appHeight(100),
          ),
          Container(
            color: Color(0xffFEC200).withOpacity(0.2),
            width: config.App(context).appWidth(100),
            height: config.App(context).appHeight(100),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      // width: config.App(context).appWidth(50),
                      // height: config.App(context).appWidth(50),
                      child: new Image.asset('assets/images/go.jpg',
                          width: 250, height: 100),
                    ),
                  ),
                  Text('Choose the difficulty level'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 22)),
                  SizedBox(height: config.App(context).appWidth(3)),
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: _listCat!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // _assetsAudioPlayer = null;
                                // _assetsAudioPlayer?.stop();
                              closePlayer();
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        _listCat![index].goto!,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 90,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: _listCat![index].primarycolor,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 4,
                                              color: Colors.black45,
                                              spreadRadius: 0.5,
                                              offset: Offset(3, 4))
                                        ]),
                                  ),
                                  Container(
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: _listCat![index].secomdarycolor,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 4,
                                              color: Colors.black12,
                                              spreadRadius: 0.3,
                                              offset: Offset(
                                                5,
                                                3,
                                              ))
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: Text(
                                          _listCat![index].name!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 36,
                                              fontWeight: FontWeight.normal,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black26,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 2),
                                                ),
                                                Shadow(
                                                    color: Colors.green,
                                                    blurRadius: 2,
                                                    offset: Offset(0.5, 2))
                                              ]),
                                        )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: genratestar(
                                              _listCat![index].noOfstar!),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> genratestar(int no) {
    List<Widget> _icons = [];
    for (int i = 0; i < no; i++) {
      _icons.insert(
          i,
          Icon(
            Icons.star,
            color: Colors.yellow,
          ));
    }
    return _icons;
  }
}

class Details {
  String? name;
  Color? primarycolor;
  Color? secomdarycolor;
  Widget? goto;
  int? noOfstar;

  Details(
      {this.name,
      this.primarycolor,
      this.secomdarycolor,
      this.noOfstar,
      this.goto});
}

List<Details>? _listCat = [
  Details(
      name: "EASY",
      primarycolor: Colors.green,
      secomdarycolor: Colors.green[300],
      noOfstar: 1,
      goto: Catergory(
        level: Level.Easy,
        timer: 5,
      )),
  Details(
      name: "MEDIUM",
      primarycolor: Colors.orange,
      secomdarycolor: Colors.orange[300],
      noOfstar: 2,
      goto: Catergory(
        level: Level.Medium,
        timer: 40,
      )),
  Details(
      name: "HARD",
      primarycolor: Colors.red,
      secomdarycolor: Colors.red[300],
      noOfstar: 3,
      goto: Catergory(
        level: Level.Hard,
        timer: 60,
      ))
];
