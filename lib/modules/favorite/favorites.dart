import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorite_model/favorites_model.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

import '../../shared/components/components.dart';
import '../../style/colors.dart';
import '../products/products_details/product_details.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return ConditionalBuilder(
          condition: state is! ShopFavoritesLoadingState,
          builder: (BuildContext context) {
            return  Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[100],
              ),
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.26,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                children: List.generate(
                    cubit.favModel!.data!.data.length,
                        (index) =>
                        favoriteItem(context, cubit.favModel!.data!.data[index])),
              ),
            );
          },
          fallback: (BuildContext context) =>
            const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget favoriteItem(context, DataModel model) =>
    BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                  children: [
                  Image(
                    image: NetworkImage(model.product!.image),
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: double.infinity,
                  ),
                    if(model.product!.discount != 0)
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                      ),

                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text('Discount'),
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'EGP ${model.product!.price.toString()}',
                      maxLines: 1,
                      style: TextStyle(
                          height: 1.8,
                          fontSize: 14,
                          color: model.product!.discount != 0
                              ? lightPrimaryColor
                              : Colors.black),
                    ),
                    const SizedBox(width: 8),
                   const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavoriteState(model.product!.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.red,
                          size: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
