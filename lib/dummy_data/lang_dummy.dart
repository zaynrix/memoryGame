import 'package:get/get.dart';

class WorldLanguage extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {

    'en_US': {
      'level': 'Choose the difficulty level',
      'going': 'Where are you going?',
      'email': 'Hello @name, your email is @email'
    },

    'ar_AR': {
      'level': 'اختر مستوى اللعب',
      'going': '¿Adónde vas?',
      'email': 'Hola @name, tu correo electrónico es @email'
    },



    //add more language here
  };
}