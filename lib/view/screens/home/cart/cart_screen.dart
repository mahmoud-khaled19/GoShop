import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app_constance/constants_methods.dart';
import '../../../../app_constance/strings_manager.dart';
import '../../../../view_model/cubit/app_cubit.dart';
import '../../../../view_model/cubit/app_states.dart';
import '../../../widgets/widgets.dart';
import '../products/products_details/product_details.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        print(cubit.carts);
        return ConditionalBuilder(
            condition: state is ! ShopGetCartsLoadingState,
            builder: (BuildContext context) {
              return cubit.carts.values.contains(true)
                  ? Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.35,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  children: List.generate(
                      cubit.cartModel!.data!.cartItems!.length,
                          (index) => favoriteItem(
                          context, cubit.cartModel!.data!.cartItems![index])),
                ),
              )
                  : Center(
                  child: Text(
                    AppStrings.noCarts.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ));
            },
            fallback: (BuildContext context) => const Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }
}

Widget favoriteItem(context, model) => BlocConsumer<ShopCubit, ShopStates>(
  listener: (BuildContext context, Object? state) {},
  builder: (BuildContext context, state) {
    return GestureDetector(
      onTap: () {
        AppMethods.navigateTo(
            context,
            ProductDetails(
                image: model.product!.image!,
                id: model.product!.id!,
                name: model.product!.name!,
                price: model.product!.price,
                description: model.product!.description!));
      },
      child: productListItem(context, model),
    );
  },
);
