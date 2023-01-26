import 'package:flutter/foundation.dart';
import '../../modules/login screen/shop_login.dart';
import '../network/local/shared_preferences.dart';
import 'components.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, const ShopAppLoginScreen());
    if (kDebugMode) {
      print('remove token');
    }
  });
}
String? token ='';