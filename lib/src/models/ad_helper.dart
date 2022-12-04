import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
    return "ca-app-pub-1852376068783494/7580762530";
      //  return 'ca-app-pub-1852376068783494/7580762530';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1852376068783494/7580762530';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId2 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1852376068783494/1880346316";
      //  return 'ca-app-pub-1852376068783494/7580762530';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1852376068783494/1880346316';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
  static String get bannerAdUnitId3 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1852376068783494/3251469439";
      //  return 'ca-app-pub-1852376068783494/7580762530';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1852376068783494/3251469439';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
  static String get bannerAdUnitId4 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1852376068783494/5983242851";
      //  return 'ca-app-pub-1852376068783494/7580762530';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1852376068783494/5983242851';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId5 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1852376068783494/6471802799";
      //  return 'ca-app-pub-1852376068783494/7580762530';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1852376068783494/6471802799';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
  static String get bannerAdUnitId6 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1852376068783494/4775577744";
      //  return 'ca-app-pub-1852376068783494/7580762530';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1852376068783494/4775577744  ';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
  // ORIGINAL ca-app-pub-1852376068783494/3320291191
//ca-app-pub-3940256099942544/1033173712
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1852376068783494/9149248662";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1852376068783494/9149248662";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }



}