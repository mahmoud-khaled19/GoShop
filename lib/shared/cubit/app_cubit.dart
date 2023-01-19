import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorite_model/favorites_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

import '../../models/category_model/category_model.dart';
import '../../modules/categories/categories.dart';
import '../../modules/favorite/favorites.dart';
import '../../modules/products/products.dart';
import '../../modules/settings/settings.dart';
import '../components/components.dart';
import '../components/constants.dart';
import '../network/end_points.dart';
import 'app_states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  HomeModelData? model;
  FavoritesModel? favModel;
  Map<int,bool>favourites={};
   CategoryModel? catModel;

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
      model = HomeModelData.fromJson(value.data);
      for (var element in model!.data.products) {
        favourites.addAll({element.id:element.favorite});
      }
      if (kDebugMode) {
        print(favourites.toString());
      }
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      emit(ShopHomeErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  void categoryModel() {
    DioHelper.getData(url: category).then((value) {
      catModel = CategoryModel.fromJson(value.data);
      if (kDebugMode) {
        print(catModel!.status);
      }
      if (kDebugMode) {
        print('Category came SuccessFully');
      }
      if (kDebugMode) {
        print(catModel!.data.currentPage);
      }
      emit(ShopCategorySuccessState());

    }).catchError((error) {
      emit(ShopCategoryErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  void changeFavoriteState(int productId){
    favourites[productId] =! favourites[productId]!;
    emit(ShopFavoritesSuccessState());
    DioHelper.postData(
        url: favorites,
        data: {'product_id':productId },
        token: token)
        .then((value) {
          favModel=FavoritesModel.fromJson(value.data);
          if(!favModel!.status){
            favourites[productId] =! favourites[productId]!;
          }
          if (kDebugMode) {
            print(favModel!.message.toString());
          }
          emit(ShopFavoritesSuccessState());
    }).catchError((error){
      if(!favModel!.status){
        favourites[productId] =! favourites[productId]!;
      }
      emit(ShopFavoritesErrorState());
    });
      if(favModel!.status){
        if(favourites[productId]!){
          defaultToast(text: 'تم إضافه المنتج إلي التفضيلات', color: Colors.green);
        }
        else{
          defaultToast(text: 'تم حذف المنتج من قائمة التفضيلات ', color: Colors.yellow);
        }
      }
      else{
        defaultToast(text: 'غير مصرح لك يرجي تسجيل الدخول من جديد', color: Colors.red);
    }
  }
}
