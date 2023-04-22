import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import '../../view_model/shared/components/constants.dart';
import '../auth/login screen/shop_login.dart';
import '../layout/shop_layout.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: MediaQuery.of(context).size.height * .5,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      nextScreen:
      token != null?
      const ShopLayout() :const ShopAppLoginScreen(),
      splash: Column(
        children: [
          const Center(
            child:Icon(Icons.shopify_outlined,size: 100)),
          const SizedBox(
            height: 25,
          ),
          Text(
            AppStrings.appTitle.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
