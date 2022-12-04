// import 'dart:collection';
// import 'dart:convert';
//
// // import 'package:active_ecommerce_flutter/app_config.dart';
// // import 'package:active_ecommerce_flutter/helpers/words.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class Messages extends Translations {
//   Messages._create() {}
//
//   static Future<Messages> create() async {
//     // Call the private constructor
//     var component = Messages._create();
//
//     // Do initialization that requires async
//     //await component._complexAsyncInit();
//     component.words = await component.fetchLanguage();
//     // Return the fully initialized object
//     return component;
//   }
//
//   Map<String, Map<String, String>> words = {};
//
//   Messages() {
//     fetchLanguage().then((value) {
//       this.words = value;
//     });
//   }
//   Future<Map<String, Map<String, String>>> fetchLanguage() async {
//     var uri = Uri.parse('${AppConfig.BASE_URL}/translation');
//     var response =
//         await http.get(uri, headers: {'Content-Type': 'application/json'});
//
//     words = new Map.from(json.decode(response.body))
//         .map<String, Map<String, String>>((key, value) =>
//             MapEntry<String, Map<String, String>>(
//                 key, Map<String, String>.from(value)));
//     return words;
//   }
//
//   set keys(data) {
//     fetchLanguage().then((value) {
//       words = value;
//       keys = words;
//     });
//   }
//
//   @override
//   Map<String, Map<String, String>> get keys => words;
// }
