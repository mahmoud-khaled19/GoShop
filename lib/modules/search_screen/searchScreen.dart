import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/search_cubit/cubit.dart';
import 'package:shop_app/modules/search_screen/search_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/cubit/app_cubit.dart';
import '../../style/colors.dart';
import '../products/products_details/product_details.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hSize = MediaQuery.of(context).size.height;
    double wSize = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                      textColor: ShopCubit.get(context).isDark
                          ? darkPrimaryColor
                          : Colors.white,
                      borderColor: ShopCubit.get(context).isDark
                          ? darkPrimaryColor
                          : Colors.white,
                      color: ShopCubit.get(context).isDark
                          ? darkPrimaryColor
                          : Colors.white,
                      prefix: Icons.search,
                      controller: searchController,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'write what you search for';
                        }
                        return null;
                      },
                      onSubmit: (value) {
                        SearchCubit.get(context)
                            .getSearch(text: searchController.text);
                      },
                      label: 'Search', function: () {  } ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is LoadingSearchState)
                    const LinearProgressIndicator(),
                  if (state is SuccessSearchState)
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cubit.model?.data?.data.length,
                          itemBuilder: (context, index) => SizedBox(
                                height: hSize * 0.15,
                                child: Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      navigateTo(
                                          context,
                                          ProductDetails(
                                              image: cubit.model!.data!
                                                  .data[index].image!,
                                              id: cubit
                                                  .model!.data!.data[index].id!,
                                              name: cubit.model!.data!
                                                  .data[index].name!,
                                              price: cubit.model!.data!
                                                  .data[index].price,
                                              description: cubit.model!.data!
                                                  .data[index].description!));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Image(
                                            image: NetworkImage(cubit.model!
                                                .data!.data[index].image!),
                                            width: wSize * 0.2,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            'EGP ${cubit.model!.data!.data[index].price.toString()}',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                height: 1.8,
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {},
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.grey[200],
                                              child: Icon(
                                                ShopCubit.get(context).favourites[
                                                cubit.model!.data!.data[index].id!]!
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: Colors.red,
                                                size: MediaQuery.of(context).size.width * 0.06,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
