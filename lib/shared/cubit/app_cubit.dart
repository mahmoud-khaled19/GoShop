import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

import '../../modules/categories/categories.dart';
import '../../modules/favorite/favorites.dart';
import '../../modules/products/products.dart';
import '../../modules/settings/settings.dart';
import '../components/constans.dart';
import '../network/end_points.dart';
import 'app_states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  late HomeModelData model;

  static ShopCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeShopTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopChangeTheme());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark);
      emit(ShopChangeTheme());
    }
  }

  int currentIndex = 0;

  void changeBottomState(index) {
    currentIndex = index;
    emit(ShopChangeNavBarStates());
  }

  void homeModel() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: home, token: token).then((value) {
      emit(ShopHomeSuccessState());
      model = HomeModelData.fromJson(value.data);
      if (kDebugMode) {
        print(model.status);
      }
      if (kDebugMode) {
        print(model.data.banners[0].image);
      }

    }).catchError((error) {
      emit(ShopHomeErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
