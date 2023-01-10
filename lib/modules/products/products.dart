import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/modules/products/products_details/product_details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

import '../../style/colors.dart';

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
            builder: (context) => productsBuilder(cubit.model,context),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}

Widget productsBuilder(HomeModelData model,context) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        const SizedBox(
          height: 10,
        ),
        GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: 1 / 1.5,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            crossAxisCount: 2,
            children: List.generate(
              model.data.products.length,
              (index) => productItem(model.data.products[index],context),
            ))
        //productItem(model.data.products[index])
      ]),
    );

Widget productItem(ProductsModel model, context) => InkWell(
  onTap: (){
    navigateTo(context, ProductDetails(
      image: model.image,
      price: 'Price : ${model.price.round()}',
      description: model.description,
      name: model.name,
    ));
  },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 200,
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white),
                    ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  model.name,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'P: ${model.price.round()}',
                      maxLines: 1,
                      style: TextStyle(fontSize: 12, color: lightPrimaryColor),
                    ),
                    const SizedBox(width: 10),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[600]),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
