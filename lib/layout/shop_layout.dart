import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/searchScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

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
            title:const Text('KOoOTa SHOP'),
            actions: [
              IconButton(icon:const Icon(Icons.compare_arrows), onPressed: () {
                WidgetsFlutterBinding.ensureInitialized();
                cubit.homeModel();
                cubit.categoryModel();
                cubit.getFavoritesItems();
                cubit.getUserdata();
              },),
              IconButton(icon:const Icon(Icons.search), onPressed: () {
                navigateTo(context,  SearchScreen());
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
                  icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
          body:cubit.screens[cubit.currentIndex]
        );
      },
    );
  }
}
