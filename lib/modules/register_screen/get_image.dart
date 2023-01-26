import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login%20screen/shop_login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

import '../../shared/cubit/app_cubit.dart';

class ImageSelection extends StatelessWidget {
  const ImageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                defaultTextButton(
                    text: 'Skip',
                    function: () {
                      navigateTo(context, const ShopAppLoginScreen());
                    }),

                const SizedBox(
                  height: 50,
                ),
                defaultElvButton(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.6,
                    text: 'Gallery',
                    function: () {
                    }),
                const SizedBox(
                  height: 10,
                ),
                defaultElvButton(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.6,
                    text: 'Camera',
                    function: () {
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
