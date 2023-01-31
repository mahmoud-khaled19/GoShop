import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/models/favorite_model/favorites_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/network/remote/dio.dart';
import '../../models/carts_model/carts_model.dart';
import '../../models/category_model/category_model.dart';
import '../../models/shop_model/shop_model.dart';
import '../../modules/cart/cart.dart';
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
  ShopModel? userInfo;
  ShopModel? updateInfo;
  FavoritesModel? favModel;
  CartsModel? cartModel;
  Map<int, bool> favourites = {};
  Map<int, bool> carts = {};
  CategoryModel? catModel;

  static ShopCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
     SettingsScreen(),
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
      for (var element in model!.data!.products) {
        favourites.addAll({element.id!: element.favorite!});
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
        print('Category came SuccessFully');
      }
      emit(ShopCategorySuccessState());
    }).catchError((error) {
      emit(ShopCategoryErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  void changeFavoriteState(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavoritesSuccessState());
    DioHelper.postData(
            url: favorites, data: {'product_id': productId}, token: token)
        .then((value) {
      favModel = FavoritesModel.fromJson(value.data);
      if (favModel?.status != null) {
        favourites[productId] != favourites[productId];
      }
      getFavoritesItems();
      emit(ShopChangeFavoritesSuccessState());
    }).catchError((error) {
      if (favModel?.status != null) {
        favourites[productId] = !favourites[productId]!;
      }
      emit(ShopChangeFavoritesErrorState());
    });
    if (favModel?.status != null) {
      if (favourites[productId]!) {
        defaultToast(
            text: 'تم إضافه المنتج إلي التفضيلات', color: Colors.green);
      } else {
        defaultToast(
            text: 'تم حذف المنتج من قائمة التفضيلات ', color: Colors.yellow);
      }
    } else {
      defaultToast(
          text: 'غير مصرح لك يرجي تسجيل الدخول من جديد', color: Colors.red);
    }
  }

  void getFavoritesItems() {
    emit(ShopFavoritesLoadingState());
    DioHelper.getData(url: favorites, token: token).then((value) {
      favModel = FavoritesModel.fromJson(value.data);
      emit(ShopFavoritesSuccessState());
    }).catchError((error) {
      emit(ShopFavoritesErrorState());
    });
  }

  void getUserdata() {
    emit(ShopUserDataLoadingState());
    DioHelper.getData(url: profile, token: token).then((value) {
      userInfo = ShopModel.fromJson(value.data);
      if (kDebugMode) {
        print(userInfo!.data!.name);
      }
      emit(ShopUserDataSuccessState());
    }).catchError((error) {
      emit(ShopUserDataErrorState());
      if (kDebugMode) {
        print(error.toString());
        print('Name Of The error');
      }
    });
  }

  void updateUserdata({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopUpdateUserinfoLoadingState());
    DioHelper.putData(url: update, token: token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      updateInfo = ShopModel.fromJson(value.data);
      if (kDebugMode) {
        print(updateInfo?.data?.name);
      }
      emit(ShopUpdateUserinfoSuccessState());
    }).catchError((error) {
      emit(ShopUpdateUserinfoErrorState());
      if (kDebugMode) {
        print(error.toString());
        print('Name Of The error');
      }
    });
  }
  File? selectedImage ;
  Future pickImage(ImageSource source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if (image ==null){
        return;
      }
      else{
        File? img =File(image.path);
        selectedImage = img;
        emit((ChangeImageSuccessState()));
      }
    } catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
      emit((ChangeImageErrorState()));
    }

  }

  void changeCartsState(int productId) {
    // carts[productId] = !carts[productId]!;
    // emit(ShopChangeCartsSuccessState());
    DioHelper.postData(
        url: cart, data: {'product_id': productId}, token: token)
        .then((value) {
      cartModel = CartsModel.fromJson(value.data);
      if (catModel?.status != null) {
        carts[productId] != carts[productId];
      }
      getCartsItems();
      emit(ShopChangeCartsSuccessState());
    }).catchError((error) {
      if (catModel?.status != null) {
        carts[productId] !=  carts[productId]!;
      }
      emit(ShopChangeCartsErrorState());
    });

      if (carts[productId]!) {
        defaultToast(
            text: 'تم إضافه المنتج إلي الشنطه', color: Colors.green);
      } else {
        defaultToast(
            text: 'تم حذف المنتج من الشنطه ', color: Colors.yellow);
    }
  }
  void getCartsItems() {
    emit(ShopCartsLoadingState());
    DioHelper.getData(url: favorites, token: token).then((value) {
      cartModel = CartsModel.fromJson(value.data);

      emit(ShopCartsSuccessState());
      print(cartModel!.data?.id);
    }).catchError((error) {
      emit(ShopCartsErrorState());
    });
  }
}
