import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper{


  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



}