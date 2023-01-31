import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/modules/settings/about_me.dart';
import 'package:shop_app/modules/settings/privacy_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/style/colors.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.12,
                      child: ClipOval(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: (cubit.selectedImage != null)
                              ? Image.file(
                                  cubit.selectedImage!,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: HexColor('#F2F3F4'),
                    ),
                    IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.showBottomSheet((context) =>
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15))),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  defaultElvButton(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      text: 'Gallery',
                                      function: () {
                                        cubit.pickImage(ImageSource.gallery);
                                      }),
                                  defaultElvButton(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      text: 'Camera',
                                      function: () {
                                        cubit.pickImage(ImageSource.camera);
                                      }),
                                ],
                              ),
                            ));
                      },
                      icon: const Icon(Icons.add_photo_alternate, size: 30),
                    ),
                  ],
                ),
                SizedBox(height: size * 0.04),
                settingItem(
                    text: "App Mode",
                    contColor:
                        cubit.isDark ? Colors.grey[100] : darkPrimaryColor,
                    texColor: cubit.isDark ? darkPrimaryColor : Colors.white,
                    function: () {
                      cubit.changeShopTheme();
                    },
                    icon: cubit.isDark ? Icons.dark_mode : Icons.brightness_4,
                    iconColor: cubit.isDark ? darkPrimaryColor : Colors.white),
                SizedBox(height: size * 0.01),
                settingItem(
                  text: " Language",
                  contColor:
                      cubit.isDark ? Colors.grey[100] : darkPrimaryColor,
                  texColor: cubit.isDark ? darkPrimaryColor : Colors.white,
                  function: () {},
                  icon: Icons.language,
                  iconColor: cubit.isDark ? darkPrimaryColor : Colors.white,
                ),
                SizedBox(height: size * 0.01),
                settingItem(
                  text: " Updates",
                  contColor:
                      cubit.isDark ? Colors.grey[100] : darkPrimaryColor,
                  texColor: cubit.isDark ? darkPrimaryColor : Colors.white,
                  function: () {
                    navigateTo(context, PrivacyScreen());
                  },
                  icon: Icons.privacy_tip_outlined,
                  iconColor: cubit.isDark ? darkPrimaryColor : Colors.white,
                ),
                SizedBox(height: size * 0.01),
                settingItem(
                  text: " About Me",
                  contColor:
                      cubit.isDark ? Colors.grey[100] : darkPrimaryColor,
                  texColor: cubit.isDark ? darkPrimaryColor : Colors.white,
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
                  iconColor: cubit.isDark ? darkPrimaryColor : Colors.white,
                ),
                SizedBox(height: size * 0.07),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultElvButton(
                        color:  cubit.isDark ? darkPrimaryColor : Colors.deepOrange,
                        width: size * 0.4,
                        text: 'Sign Out',
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
