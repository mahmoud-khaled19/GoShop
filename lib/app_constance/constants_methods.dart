import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../view/screens/auth/login screen/shop_login.dart';
import '../../view_model/shared/network/local/shared_preferences.dart';
class AppMethods {
  static void navigateAndFinish(context, widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  static void navigateTo(context, widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void signOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      CacheHelper.removeData(key: 'token');
      if (value!) {
        navigateAndFinish(context,  ShopAppLoginScreen());
      }
      if (kDebugMode) {
        print('remove token');
      }
    });
  }

  static String? token = '';
}
