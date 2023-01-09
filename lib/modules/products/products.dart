import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constans.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return ConditionalBuilder(
            condition: state is! ShopHomeLoadingState,
            builder: (context) => productsBuilder(cubit.model, context),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}

Widget productsBuilder(HomeModelData model, context) => Column(children: [
      CarouselSlider(
          items: model.data.banners
              .map((e) => Image(
                    image: NetworkImage(e.image),
                    width: double.infinity,
                    fit: BoxFit.fill,
                    height: 250,
                  ))
              .toList(),
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              scrollDirection: Axis.horizontal,
              autoPlayAnimationDuration: const Duration(seconds: 4),
              autoPlayCurve: Curves.fastOutSlowIn)),
      Center(
        child: defaultTextButton( 
            text: 'Sign Out',
            function: () {
              signOut(context);
            }),
      )
    ]);
