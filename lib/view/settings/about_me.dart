import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/strings_manager.dart';

import '../../view_model/cubit/app_cubit.dart';
import '../../view_model/cubit/app_states.dart';

class AboutMe extends StatelessWidget {
  final String? name;
  final String? phone;
  final String? email;

  const AboutMe({super.key, this.name, this.email, this.phone});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('About Me')),
        ),
        body: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  color: Theme.of(context).cardColor,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    title: Text(AppStrings.nameLabel.tr(),
                        style: Theme.of(context).textTheme.titleLarge),
                    subtitle: Text(name!,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
                SizedBox(height: size * 0.01),
                Container(
                  color: Theme.of(context).cardColor,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    title: Text(AppStrings.emailLabel.tr(),
                        style: Theme.of(context).textTheme.titleLarge),
                    subtitle: Text(email!,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
                SizedBox(height: size * 0.01),
                Container(
                  color: Theme.of(context).cardColor,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    title: Text(AppStrings.phoneLabel.tr(),
                        style: Theme.of(context).textTheme.titleLarge),
                    subtitle: Text(phone!,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
