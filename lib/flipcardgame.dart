import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muslim/config/app_config.dart' as config;
import 'package:muslim/src/elements/BlockButtonWidget.dart';
import 'package:muslim/src/models/ad_helper.dart';

import 'data.dart';

class FlipCardGane extends StatefulWidget {
  late final Level _level;
  late List<dynamic> _data;
  late int _start2;

  FlipCardGane(this._level, this._data, this._start2);

  @override
  _FlipCardGaneState createState() => _FlipCardGaneState(_level);
}

class _FlipCardGaneState extends State<FlipCardGane> {
  _FlipCardGaneState(this._level);

  late int _previousIndex = -1;
  late bool _flip = false;
  late bool _start = false;
  late BannerAd _bannerAd, _bannerAd2, _bannerAd3, _bannerAd4;
  bool _isBannerAdReady = false;
  bool _isBannerAdReady2 = false;
  bool _isBannerAdReady3 = false;
  bool _isBannerAdReady4 = false;

  late bool _wait = false;
  Level _level;
  late Timer _timer, _timer1;
  late int _time = 5;
  late int _left;
  late bool _isFinished;
  late List<dynamic> dataList;
  AssetsAudioPlayer? _assetsAudioPlayer;
  late double dialogHeight;
  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;

  void openPlayer(String fname) async {
    print("openPlayer");

    await _assetsAudioPlayer!.open(Audio('assets/songs/$fname.mp3'));
  }

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(4.0),
      child: Image.asset(dataList[index]),
    );
  }

  // showAlertDialog(BuildContext context) {
  //   openPlayer("gameover");
  //
  //   // set up the button
  //   Widget okButton = TextButton(
  //     child: Text("Again"),
  //     onPressed: () {},
  //   );
  //   Widget backButton2 = TextButton(
  //     child: Text("Back"),
  //     onPressed: () {},
  //   );
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     backgroundColor: Colors.white,
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(32.0))),
  //
  //     // backgroundColor: Colors.lime,
  //     title: Column(
  //       children: [
  //         Center(
  //           child: Image.asset(
  //             "assets/images/go.png",
  //             fit: BoxFit.fill,
  //
  //             // width: config.App(context).appWidth(100),
  //             // height: config.App(context).appHeight(100),
  //           ),
  //         ),
  //         Text("Your Score is ${_left * 3}/${dataList.length * 3}"),
  //         BlockButtonWidget(
  //             title: "Play",
  //             boxColors: Colors.blueGrey,
  //             boxColors2: Colors.blue,
  //             onPressed: () {
  //               Navigator.pop(context);
  //               setState(() {
  //                 restart();
  //               });
  //             }),
  //         Row(
  //           // crossAxisAlignment:,
  //           // mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             IconButton(
  //                 onPressed: () {},
  //                 icon: Icon(
  //                   Icons.play_arrow,
  //                   size: 42,
  //                   color: Colors.orange,
  //                 ))
  //           ],
  //         )
  //       ],
  //     ),
  //     // content: Text("This is my message."),
  //     // actions: [
  //     //
  //     //   backButton2,
  //     //   okButton,
  //     // ],
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        _time = _time - 1;
      });
    });

    // Future.delayed(Duration(seconds: _time), () {
    //   startTimer2();
    // });
  }

  void restart() {
    startTimer();
    // startTimer2();

    dataList = getSourceArrayCategory(_level, widget._data);
    _cardFlips = getInitialItemState(_level);
    _cardStateKeys = getCardStateKeys(_level);
    _time = 5;
    _left = (dataList.length ~/ 2);

    _isFinished = false;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        openPlayer("start");
      });
    });
    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer!.playOrPause();
    _bannerAd2 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId3,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady2 = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady2 = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId4,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd3 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId5,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady3 = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady3 = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd4 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId6,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady4 = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady4 = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd2.load();
    _bannerAd3.load();
    _bannerAd4.load();

    _bannerAd.load();
    restart();
  }

  @override
  void dispose() {
    // _timer1.cancel();
    _timer.cancel();
    _assetsAudioPlayer = null;
    _bannerAd.dispose();
    _bannerAd2.dispose();
    _bannerAd3.dispose();
    _bannerAd4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isFinished
        ? WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Stack(
                children: [
                  Image.asset(
                    "assets/images/back3.png",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (_isBannerAdReady3)
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              color: Colors.white,
                              width: _bannerAd.size.width.toDouble(),
                              height: _bannerAd.size.height.toDouble(),
                              child: AdWidget(ad: _bannerAd3),
                            ),
                          ),
                        // if (_isBannerAdReady)
                        //   Align(
                        //     alignment: Alignment.topCenter,
                        //     child: Container(
                        //       color: Colors.white,
                        //       width: _bannerAd.size.width.toDouble(),
                        //       height: _bannerAd.size.height.toDouble(),
                        //       child: AdWidget(ad: _bannerAd),
                        //     ),
                        //   ),
                        Image.asset(
                          "assets/images/yes.gif",
                          width: config.App(context).appWidth(100),
                          height: config.App(context).appWidth(100),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BlockButtonWidget(
                              title: "Play again",
                              boxColors: Colors.blueGrey,
                              boxColors2: Colors.blue,
                              onPressed: () {
                                // Navigator.pop(context);
                                setState(() {
                                  restart();
                                });
                              }),
                        ),
                        SizedBox(
                          height: config.App(context).appWidth(10),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/HomePage');

                            // restart();
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
                              "Back to Home",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        // if (_isBannerAdReady2)
                        //   Expanded(
                        //     child: Align(
                        //       alignment: Alignment.bottomCenter,
                        //       child: Container(
                        //         color: Colors.white,
                        //         width: _bannerAd.size.width.toDouble(),
                        //         height: _bannerAd.size.height.toDouble(),
                        //         child: AdWidget(ad: _bannerAd2),
                        //       ),
                        //     ),
                        //   )
                        if (_isBannerAdReady4)
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Colors.white,
                                width: _bannerAd.size.width.toDouble(),
                                height: _bannerAd.size.height.toDouble(),
                                child: AdWidget(ad: _bannerAd4),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: SafeArea(
                  child: Stack(
                children: [
                  Image.asset(
                    "assets/images/back3.png",
                    fit: BoxFit.fill,
                    width: config.App(context).appWidth(100),
                    height: config.App(context).appHeight(100),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Colors.red,
                        Color(0xffFEC200).withOpacity(0.5)
                      ],
                    )),

                    // color: Color(0xffFEC200).withOpacity(0.3),
                    width: config.App(context).appWidth(100),
                    height: config.App(context).appHeight(100),
                  ),
                  SingleChildScrollView(
                    child: Wrap(
                      children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.,
                          children: <Widget>[
                            if (_isBannerAdReady2)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: Colors.white,
                                  width: _bannerAd.size.width.toDouble(),
                                  height: _bannerAd.size.height.toDouble(),
                                  child: AdWidget(ad: _bannerAd2),
                                ),
                              ),
                            // if (_isBannerAdReady)
                            //   Align(
                            //     alignment: Alignment.topCenter,
                            //     child: Container(
                            //       color: Colors.white,
                            //       width: _bannerAd.size.width.toDouble(),
                            //       height: _bannerAd.size.height.toDouble(),
                            //       child: AdWidget(ad: _bannerAd),
                            //     ),
                            //   ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.close),
                                  color: Colors.transparent,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: _time > 0
                                      ? Column(
                                          children: [
                                            Text(
                                              'Ready? $_time',
                                              style: TextStyle(
                                                  fontSize: 24, color: Colors.white),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Text(
                                              'Remaining Cards: $_left',
                                              style: TextStyle(
                                                  fontSize: 24, color: Colors.white),
                                            ),
                                            // Text(
                                            //   'Time left: ${widget._start2}',
                                            //   style: TextStyle(
                                            //       fontSize: 20,
                                            //       color: Colors.white),
                                            // ),
                                          ],
                                        ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _timer.cancel();
                                    },
                                    icon: Icon(
                                      Icons.close_outlined,
                                      color: Colors.white,
                                      size: 36,
                                    ))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) => _start
                                      ? FlipCard(
                                          key: _cardStateKeys[index],
                                          onFlip: () {
                                            if (!_flip) {
                                              _flip = true;
                                              _previousIndex = index;
                                            } else {
                                              _flip = false;
                                              if (_previousIndex != index) {
                                                if (dataList[_previousIndex] !=
                                                    dataList[index]) {
                                                  _wait = true;
                                                  openPlayer("over");
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 1500), () {
                                                    _cardStateKeys[_previousIndex]
                                                        .currentState!
                                                        .toggleCard();

                                                    _previousIndex = index;
                                                    _cardStateKeys[_previousIndex]
                                                        .currentState!
                                                        .toggleCard();

                                                    // openPlayer("good");
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 160), () {
                                                      setState(() {
                                                        // openPlayer("good");
                                                        _wait = false;
                                                      });
                                                    });
                                                  });
                                                } else {
                                                  _cardFlips[_previousIndex] = false;
                                                  _cardFlips[index] = false;
                                                  print(_cardFlips);

                                                  setState(() {
                                                    // openPlayer("good");
                                                    openPlayer("good");
                                                    _left -= 1;
                                                  });
                                                  if (_cardFlips
                                                      .every((t) => t == false)) {
                                                    print("Won");
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 500), () {
                                                      setState(() {
                                                        _isFinished = true;
                                                        // openPlayer("gameover");
                                                        _start = false;
                                                        openPlayer("gameover");
                                                      });
                                                    });
                                                  }
                                                }
                                              }
                                            }
                                            setState(() {});
                                          },
                                          flipOnTouch:
                                              _wait ? false : _cardFlips[index],
                                          direction: FlipDirection.HORIZONTAL,
                                          front: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blueGrey,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black45,
                                                    blurRadius: 3,
                                                    spreadRadius: 0.8,
                                                    offset: Offset(2.0, 1),
                                                  )
                                                ]),
                                            margin: EdgeInsets.all(4.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "assets/animalspics/quest.png",
                                              ),
                                            ),
                                          ),
                                          back: getItem(index))
                                      : getItem(index),
                                  itemCount: dataList.length,
                                ),
                              ),
                            ),
                            if (_isBannerAdReady)
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    color: Colors.white,
                                    width: _bannerAd.size.width.toDouble(),
                                    height: _bannerAd.size.height.toDouble(),
                                    child: AdWidget(ad: _bannerAd),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          );
  }
}
