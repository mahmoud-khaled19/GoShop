import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/view/settings/privacy_screen.dart';

import '../../view_model/cubit/app_cubit.dart';
import '../../view_model/cubit/app_states.dart';
import '../../view_model/shared/components/components.dart';
import '../../view_model/shared/components/constants.dart';
import '../../view_model/shared/network/local/shared_preferences.dart';
import 'about_me.dart';
import 'language/localization.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return Scaffold(
          key: scaffoldKey,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.12,
                    child: ClipOval(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child:  Image.network(
                                "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                SizedBox(height: size * 0.04),
                settingItem(
                  context: context,
                  text:
                      cubit.isDark ? AppStrings.lightMode.tr() : AppStrings.darkMode.tr(),
                  function: () {
                    cubit.changeShopTheme();
                  },
                  icon: cubit.isDark ? Icons.dark_mode : Icons.brightness_4,
                ),
                SizedBox(height: size * 0.01),
                const LocalizationTheme(),
                SizedBox(height: size * 0.01),
                settingItem(
                  context: context,
                  text: AppStrings.update.tr(),
                  function: () {
                    navigateTo(context, PrivacyScreen());
                  },
                  icon: Icons.privacy_tip_outlined,
                ),
                SizedBox(height: size * 0.01),
                settingItem(
                  context: context,
                  text: AppStrings.aboutMe.tr(),
                  function: () {
                    navigateTo(
                        context,
                        AboutMe(
                          name: ShopCubit.get(context).userInfo!.data!.name,
                          phone: ShopCubit.get(context).userInfo!.data!.phone,
                          email: ShopCubit.get(context).userInfo!.data!.email,
                        ));
                  },
                  icon: Icons.person,
                ),
                SizedBox(height: size * 0.07),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultElvButton(
                        context: context,
                        width: size * 0.4,
                        text: AppStrings.signOut.tr(),
                        function: () {
                          signOut(context);
                        }),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
