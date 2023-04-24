import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/carts_model/carts_model.dart';
import 'package:shop_app/models/favorite_model/favorites_model.dart';
import '../../app_constance/api_constance.dart';
import '../../app_constance/constants_methods.dart';
import '../../models/category_model/category_model.dart';
import '../../models/products_model/products_model.dart';
import '../../models/shop_model/shop_model.dart';
import '../../view/screens/home/cart/cart_screen.dart';
import '../../view/screens/home/categories/categories.dart';
import '../../view/screens/home/favorite/favorites.dart';
import '../../view/screens/home/products/products.dart';
import '../../view/screens/home/settings/settings.dart';
import '../../view/widgets/widgets.dart';
import '../shared/network/local/shared_preferences.dart';
import '../shared/network/remote/dio.dart';
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
  List<FavoritesModel> testList = [];

  static ShopCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    SettingsScreen(),
  ];
  bool isDark = false;

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
    DioHelper.getData(url: ApiConstance.home, token: AppMethods.token)
        .then((value) {
      model = HomeModelData.fromJson(value.data);
      for (var element in model!.data!.products) {
        favourites.addAll({element.id!: element.favorite!});
        carts.addAll({element.id!: element.inCart!});
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
    DioHelper.getData(url: ApiConstance.category).then((value) {
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
            url: ApiConstance.favorites,
            data: {'product_id': productId},
            token: AppMethods.token)
        .then((value) {
      favModel = FavoritesModel.fromJson(value.data);
      getFavoritesItems();
      if (favModel?.status != null) {
        favourites[productId] != favourites[productId];
      }

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
    }
  }

  void getFavoritesItems() {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(url: ApiConstance.favorites, token: AppMethods.token)
        .then((value) {
      favModel = FavoritesModel.fromJson(value.data);
      emit(ShopFavoritesSuccessState());
    }).catchError((error) {
      emit(ShopFavoritesErrorState());
    });
  }

  void getUserdata() {
    emit(ShopUserDataLoadingState());
    DioHelper.getData(url: ApiConstance.profile, token: AppMethods.token)
        .then((value) {
      userInfo = ShopModel.fromJson(value.data);
      if (kDebugMode) {
        print(userInfo!.data!.name);
      }
      emit(ShopUserDataSuccessState());
    }).catchError((error) {
      emit(ShopUserDataErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void updateUserdata({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopUpdateUserinfoLoadingState());
    DioHelper.putData(url: ApiConstance.update, token: AppMethods.token, data: {
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
      }
    });
  }

  void changeCartsState(int productId) {
    carts[productId] = !carts[productId]!;
    emit(ShopChangeCartsSuccessState());
    DioHelper.postData(
            url: ApiConstance.cart,
            data: {'product_id': productId},
            token: AppMethods.token)
        .then((value) {
      cartModel = CartsModel.fromJson(value.data);
      if (catModel?.status == false) {
        carts[productId] = !carts[productId]!;
      }
      getCartsItems();
      emit(ShopChangeCartsSuccessState());
    }).catchError((error) {
      carts[productId] = !carts[productId]!;
      emit(ShopChangeCartsErrorState());
    });

    if (carts[productId]!) {
      defaultToast(text: 'تم إضافه المنتج إلي الشنطه', color: Colors.green);
    } else {
      defaultToast(text: 'تم حذف المنتج من الشنطه ', color: Colors.yellow);
    }

  }

  Future<void> getCartsItems() async {
    emit(ShopGetCartsLoadingState());
    await DioHelper.getData(url: ApiConstance.cart, token: AppMethods.token)
        .then((value) {
      cartModel = CartsModel.fromJson(value.data);

      emit(ShopGetCartsSuccessState());
    }).catchError((error) {
      emit(ShopGetCartsErrorState());
      print(error.toString());
    });
  }
}
