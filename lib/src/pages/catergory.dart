import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muslim/config/app_config.dart' as config;
import 'package:muslim/data.dart';
import 'package:muslim/flipcardgame.dart';
import 'package:muslim/src/models/ad_helper.dart';

class Catergory extends StatefulWidget {
  final Level? level;
  final int? timer;

  Catergory({Key? key, this.level, this.timer}) : super(key: key);

  @override
  _CatergoryState createState() => _CatergoryState();
}

class _CatergoryState extends State<Catergory> {
  List? data;
  late BannerAd _bannerAd, _bannerAd2;
  bool _isBannerAdReady = false;
  bool _isBannerAdReady2 = false;



  // void _loadInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId: AdHelper.bannerAdUnitId,
  //     request: AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         this._interstitialAd = ad;
  //
  //         ad.fullScreenContentCallback = FullScreenContentCallback(
  //           onAdDismissedFullScreenContent: (ad) {},
  //         );
  //
  //         _isInterstitialAdReady = true;
  //       },
  //       onAdFailedToLoad: (err) {
  //         print('Failed to load an interstitial ad: ${err.message}');
  //         _isInterstitialAdReady = false;
  //       },
  //     ),
  //   );
  // }
  //

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/datadummy.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    _bannerAd2 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId2,
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
      adUnitId: AdHelper.bannerAdUnitId,
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
    _bannerAd2.load();

    _bannerAd.load();
    super.initState();
    // _loadInterstitialAd();
    this.loadJsonData();
  }

  @override
  void dispose() {
    // _assetsAudioPlayer.stop();
    print('dispose');
    _bannerAd.dispose();
    _bannerAd2.dispose();

    // _interstitialAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                colors: <Color>[Colors.red, Color(0xffFEC200).withOpacity(0.5)],
              )),

              // color: Color(0xffFEC200).withOpacity(0.3),
              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(100),
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.,
              children: <Widget>[
                if (_isBannerAdReady)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.white,
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  ),

                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Container(
                //     color: Colors.white,
                //     width: _bannerAd.size.width.toDouble(),
                //     height: _bannerAd.size.height.toDouble(),
                //     child: AdWidget(ad: _bannerAd2),
                //   ),
                // ),

                SizedBox(
                  // width: config.App(context).appWidth(100),
                  height: config.App(context).appHeight(15),
                ),
                // IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.close_outlined,
                //       color: Colors.transparent,
                //       size: 36,
                //     )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      var name = data![index]['title'];
                      var cover = data![index]['cover'];
                      List<dynamic> pict = data![index]['address'];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => FlipCardGane(
                                    widget.level!, pict, widget.timer!),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.all(4.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Image.asset(
                                      "$cover",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                    name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                    itemCount: data == null ? 0 : data!.length,
                  ),
                ),

                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     color: Colors.white,
                //     width: _bannerAd.size.width.toDouble(),
                //     height: _bannerAd.size.height.toDouble(),
                //     child: AdWidget(ad: _bannerAd2),
                //   ),
                // ),

                if (_isBannerAdReady2)
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        width: _bannerAd.size.width.toDouble(),
                        height: _bannerAd.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd2),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// List<Widget> genratestar(int no) {
//   List<Widget> _icons = [];
//   for (int i = 0; i < no; i++) {
//     _icons.insert(
//         i,
//         Icon(
//           Icons.star,
//           color: Colors.yellow,
//         ));
//   }
//   return _icons;
// }

// class Details {
//   String? name;
//   Color? primarycolor;
//   Color? secomdarycolor;
//   Widget? goto;
//   int? noOfstar;
//
//   Details(
//       {this.name,
//       this.primarycolor,
//       this.secomdarycolor,
//       this.noOfstar,
//       this.goto});
// }

// List<Details>? _list = [
//   Details(
//       name: "EASY",
//       primarycolor: Colors.green,
//       secomdarycolor: Colors.green[300],
//       noOfstar: 1,
//       goto: FlipCardGane(Level.Easy)),
//   Details(
//       name: "MEDIUM",
//       primarycolor: Colors.orange,
//       secomdarycolor: Colors.orange[300],
//       noOfstar: 2,
//       goto: FlipCardGane(Level.Medium)),
//   Details(
//       name: "HARD",
//       primarycolor: Colors.red,
//       secomdarycolor: Colors.red[300],
//       noOfstar: 3,
//       goto: FlipCardGane(Level.Hard))
// ];
