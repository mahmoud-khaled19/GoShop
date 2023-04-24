import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';

import '../../../generated/assets.dart';
import '../../../view_model/cubit/app_cubit.dart';
import '../../../view_model/cubit/search_cubit/cubit.dart';
import '../../../view_model/cubit/search_cubit/states.dart';
import '../../widgets/widgets.dart';
import '../home/products/products_details/product_details.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

  SearchScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
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
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                        context: context,
                        prefix: Icons.search,
                        controller: searchController,
                        validate: (String? value) {
                          return 'Write SomeThing to Search For';
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            SearchCubit.get(context)
                                .getSearch(text: searchController.text);
                          }
                        },
                        label: AppStrings.search.tr()),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is LoadingSearchState)
                      const LinearProgressIndicator(),
                    if (state is! LoadingSearchState &&
                        state is! SuccessSearchState)
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: size * 0.05,
                            ),
                            const Image(
                              image: AssetImage(Assets.imagesSearch),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                AppStrings.searchScreen.tr(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (state is SuccessSearchState &&
                        cubit.model!.data!.data.isEmpty)
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: size * 0.05,
                            ),
                            Image(
                              height: size * 0.3,
                              image: const AssetImage(Assets.imagesSearch),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                AppStrings.searchScreen2.tr(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (state is SuccessSearchState &&
                        cubit.model!.data!.data.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.model!.data!.data.length,
                            itemBuilder: (context, index) => SizedBox(
                                  height: size * 0.15,
                                  child: Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        AppMethods.navigateTo(
                                            context,
                                            ProductDetails(
                                                image: cubit.model!.data!
                                                    .data[index].image!,
                                                id: cubit.model!.data!
                                                    .data[index].id!,
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
                                              width: size * 0.2,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    cubit.model!.data!
                                                        .data[index].name!,
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
                                            Icon(
                                              ShopCubit.get(context).favourites[
                                                      cubit.model!.data!
                                                          .data[index].id!]!
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
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
            ),
          );
        },
      ),
    );
  }
}
