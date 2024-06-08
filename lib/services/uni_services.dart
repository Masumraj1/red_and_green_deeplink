// import 'dart:math';
//
// import 'package:final_project/green.dart';
// import 'package:final_project/services/context_utility.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:uni_links/uni_links.dart';
//
// import '../red.dart';
//
// class UniServices{
// static String _code = "";
// static String get code => _code;
// static bool get hasCode => _code.isNotEmpty;
//
//
// static void reset() => _code = '';
//
//
// static init()async{
//   try{
//      final Uri? uri = await getInitialUri();
//      uniHandler(uri);
//   }on PlatformException  {
//   log(12);
//   }on FormatException{
//     log(123);
//   }
//
//   uriLinkStream.listen((Uri? uri) async{
//     uniHandler(uri);
//   },onError:(error) {
//     log(1234);
//   });
// }
//
// static uniHandler(Uri? uri){
//   if( uri == null || uri.queryParameters.isEmpty ) return;
//
//   Map<String,String> param = uri.queryParameters;
//
//
//   String receivedCode = param['code'] ?? "";
//
//
//   if(receivedCode == "green"){
//     Navigator.push(ContextUtility.context!,MaterialPageRoute(builder: (_) => const Green()));
//   }else{
//     Navigator.push(ContextUtility.context!,MaterialPageRoute(builder: (_) => const Red()));
//
//   }
// }
// }



import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import '../green.dart';
import '../red.dart';
import 'context_utility.dart';

class UniServices {   
  static String _code = "";
  static String get code => _code;
  static bool get hasCode => _code.isNotEmpty;

  static void reset() => _code = '';

  static Future<void> init() async {
    final appLinks = AppLinks();

    // Handle the app being opened from a terminated state
    try {
      final uri = await appLinks.getInitialAppLink();
      uniHandler(uri);
    } catch (e) {
      print("Error receiving initial app link: $e");
    }

    // Handle the app being opened in the foreground from a deep link
    appLinks.uriLinkStream.listen((uri) {
      uniHandler(uri);
    }, onError: (err) {
      print("Error receiving app link stream: $err");
    });
  }

  static void uniHandler(Uri? uri) {
    if (uri == null || uri.queryParameters.isEmpty) return;

    Map<String, String> param = uri.queryParameters;

    String receivedCode = param['code'] ?? "";

    if (receivedCode == "green") {
      Navigator.push(
        ContextUtility.context!,
        MaterialPageRoute(builder: (_) => const Green()),
      );
    } else {
      Navigator.push(
        ContextUtility.context!,
        MaterialPageRoute(builder: (_) => const Red()),
      );
    }
  }
}