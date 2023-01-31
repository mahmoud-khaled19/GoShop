import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/boarding_screen/boarding-screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/style/colors.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: MediaQuery.of(context).size.height * .5,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: HexColor('#F2F3F4'),
      nextScreen:
      token != null?
      const ShopLayout() : const ShopAppBoardingScreen(),
      splash: Column(
        children: [
          const Center(
            child:Icon(Icons.shopify_outlined,size: 100)),
          const SizedBox(
            height: 25,
          ),
          Text(
            'K0oOta Shop',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:darkPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}
