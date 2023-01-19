import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model/category_model.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/style/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ShopCubit cubit = BlocProvider.of(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: cubit.catModel != null,
            builder: (context) => categoryItem(cubit.catModel!,context),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}

Widget categoryItem(CategoryModel model,context) => RefreshIndicator(
      displacement: 100,
      onRefresh: () {
        return refresh();
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var size =MediaQuery.of(context).size;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[50],
              ),
              margin: const EdgeInsets.only(
                bottom: 15,left: 20,right: 20
              ),
              width: size.width * 0.22,
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage(model.data.data[index].image),
                    width: size.width *0.6,
                    height: size.width *0.42,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Center(
                        child: Text(
                          model.data.data[index].name,
                          style:  TextStyle(fontSize: 18,color:lightPrimaryColor),
                        ),
                      ),
                      const Spacer(),
                      IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_forward_ios_sharp))
                    ],
                  )
                ],
              ),
            );
          },
          itemCount: model.data.data.length,
        ),
      ),
    );

Future<void> refresh() {
  return Future.delayed(const Duration(seconds: 10));
}
