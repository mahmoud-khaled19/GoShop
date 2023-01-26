import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/modules/settings/about_me.dart';
import 'package:shop_app/modules/settings/privacy_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

import '../../shared/network/local/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {
      },
      builder: (BuildContext context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: const[
                  CircleAvatar(
                    radius: 85,
                  backgroundColor: Colors.grey,
                  ),

                ],
              ),
              SizedBox(height: size * 0.04),
              Container(
                color: Colors.grey[100],
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  style: ListTileStyle.list,
                  title: const Text("App Mode"),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.brightness_4),
                  ),
                ),
              ),
              SizedBox(height: size * 0.01),
              Container(
                color: Colors.grey[100],
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  style: ListTileStyle.list,
                  title: const Text("Language"),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.language),
                  ),
                ),
              ),
              SizedBox(height: size * 0.01),
              Container(
                color: Colors.grey[100],
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  style: ListTileStyle.list,
                  title: const Text("Privacy"),
                  trailing: IconButton(
                    onPressed: () {
                      navigateTo(context,  PrivacyScreen());
                    },
                    icon: const Icon(Icons.privacy_tip_outlined),
                  ),
                ),
              ),
              SizedBox(height: size * 0.01),
              Container(
                color: Colors.grey[100],
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  style: ListTileStyle.list,
                  title: const Text("About Me"),
                  trailing: IconButton(
                      onPressed: () {
                        navigateTo(
                            context,
                            AboutMe(
                              name: ShopCubit.get(context).userInfo!.data!.name,
                              phone:
                                  ShopCubit.get(context).userInfo!.data!.phone,
                              email:
                                  ShopCubit.get(context).userInfo!.data!.email,
                            ));
                      },
                      icon: const Icon(Icons.person)),
                ),
              ),
              SizedBox(height: size * 0.07),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultElvButton(
                      color: Colors.red,
                      width: size * 0.4,
                      text: 'Sign Out',
                      function: () {
                        signOut(context);
                      }),

                ],
              )
            ],
          ),
        );
      },
    );
  }
}
