import 'package:flutter/foundation.dart';
import 'package:shop_app/view/auth/login%20screen/shop_login.dart';
import '../network/local/shared_preferences.dart';
import 'components.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    CacheHelper.removeData(key: 'token');
    if (value!){
      navigateAndFinish(context, const ShopAppLoginScreen());
    }
    if (kDebugMode) {
      print('remove token');
    }
  });
}
String? token ='';