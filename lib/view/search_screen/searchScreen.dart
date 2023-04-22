import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/strings_manager.dart';

import '../../view_model/cubit/app_cubit.dart';
import '../../view_model/cubit/search_cubit/cubit.dart';
import '../../view_model/cubit/search_cubit/states.dart';
import '../../view_model/shared/components/components.dart';
import '../products/products_details/product_details.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

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
                      context: context,
                      prefix: Icons.search,
                      controller: searchController,
                      validate: (String? value) {},
                      onSubmit: (value) {
                        SearchCubit.get(context)
                            .getSearch(text: searchController.text);
                      },
                      label: AppStrings.search.tr()),
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
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  cubit.model!.data!.data[index]
                                                      .name!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                                Text(
                                                  'EGP ${cubit.model!.data!.data[index].price.toString()}',
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      height: 1.8,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {},
                                            icon: CircleAvatar(
                                              backgroundColor: Colors.grey[200],
                                              child: Icon(
                                                ShopCubit.get(context)
                                                            .favourites[
                                                        cubit.model!.data!
                                                            .data[index].id!]!
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: Colors.red,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06,
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
