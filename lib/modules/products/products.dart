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
            condition: cubit.model != null,
            builder: (context) => productsBuilder(cubit.model!, context),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}

Widget productsBuilder(HomeModelData model, context) => RefreshIndicator(
      displacement: 60,
      onRefresh: () {
        return refresh();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
              items: model.data!.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image!),
                        width: double.infinity,
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height * 0.25,
                      ))
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  scrollDirection: Axis.horizontal,
                  autoPlayAnimationDuration: const Duration(seconds: 4),
                  autoPlayCurve: Curves.fastOutSlowIn)),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'New Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[100],
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1 / 1.44,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                crossAxisCount: 2,
                children: List.generate(
                  model.data!.products.length,
                  (index) => productItem(model.data!.products[index], context),
                )),
          )
        ]),
      ),
    );

Widget productItem(ProductsModel model, context) =>
    BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(5),
          child: InkWell(
            onTap: () {
              navigateTo(
                  context,
                  ProductDetails(
                    image: model.image!,
                    id: model.id,
                    price: 'Price : ${model.price.round()}',
                    description: model.description!,
                    name: model.name!,
                  ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(model.image!),
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: double.infinity,
                        ),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavoriteState(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              ShopCubit.get(context).favourites[model.id]!
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: MediaQuery.of(context).size.width * 0.06,
                            ),
                          ),
                        )
                      ],
                    ),
                    if(model.discount != 0)
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)
                        ),

                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: const Text('Discount',style: TextStyle(
                            color: Colors.white
                        ),),
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Egp ${model.price.round()}',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14, color: model.discount != 0? lightPrimaryColor:Colors.black),
                          ),
                          const SizedBox(width: 8),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice.round()}',
                              style: TextStyle(
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey[600]),
                            ),
                          // const Spacer(),
                          // IconButton(
                          //   onPressed: () {
                          //     ShopCubit.get(context)
                          //         .changeFavoriteState(model.id);
                          //     if (kDebugMode) {
                          //       print(model.id);
                          //     }
                          //   },
                          //   icon: CircleAvatar(
                          //     backgroundColor: Colors.grey[300],
                          //     child: Icon(
                          //       ShopCubit.get(context).favourites[model.id]!
                          //           ? Icons.favorite
                          //           : Icons.favorite_border,
                          //       color: Colors.red,
                          //       size: MediaQuery.of(context).size.width * 0.06,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        model.name!,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                            height: model.name!.characters.length <= 20
                                ? MediaQuery.of(context).size.height * .0038
                                : MediaQuery.of(context).size.height * .0019),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );

Future<void> refresh() {
  return Future.delayed(const Duration(seconds: 10));
}
