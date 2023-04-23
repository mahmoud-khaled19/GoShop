import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/strings_manager.dart';

import '../../../../app_constance/constants_methods.dart';
import '../../../../view_model/cubit/app_cubit.dart';
import '../../../../view_model/cubit/app_states.dart';
import '../../../widgets/widgets.dart';
import '../../search_screen/searchScreen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.appTitle.tr(),style:Theme.of(context).textTheme.titleMedium,),
            actions: [
              IconButton(icon:const Icon(Icons.compare_arrows), onPressed: () {
                WidgetsFlutterBinding.ensureInitialized();
                cubit.homeModel();
                cubit.categoryModel();
                cubit.getFavoritesItems();
                cubit.getUserdata();
                cubit.getCartsItems();
              },),
              IconButton(icon:const Icon(Icons.search), onPressed: () {
                AppMethods.navigateTo(context,  SearchScreen());
              },),

              const SizedBox(
                width: 5,
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              cubit.changeBottomState(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: AppStrings.homeNavBar),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: AppStrings.categoriesNavBar),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: AppStrings.favouritesNavBar),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_rounded), label: AppStrings.favouritesNavBar),

              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: AppStrings.settingsNavBar),
            ],
          ),
          body:cubit.screens[cubit.currentIndex]
        );
      },
    );
  }
}
