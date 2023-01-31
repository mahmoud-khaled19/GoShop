import 'package:shop_app/models/shop_model/shop_model.dart';

abstract class ShopStates{}
 class ShopInitialState extends ShopStates{}
 class ShopChangeTheme extends ShopStates{}
 class ShopChangeNavBarStates extends ShopStates{}
 class ShopHomeLoadingState extends ShopStates{}
 class ShopHomeSuccessState extends ShopStates{}
 class ShopHomeErrorState extends ShopStates{}
class ShopCategorySuccessState extends ShopStates{}
class ShopCategoryErrorState extends ShopStates{}
class ShopChangeFavoritesSuccessState extends ShopStates{}
class ShopChangeFavoritesErrorState extends ShopStates{}
class ShopFavoritesSuccessState extends ShopStates{}
class ShopFavoritesLoadingState extends ShopStates{}
class ShopFavoritesErrorState extends ShopStates{}
class ShopUserDataSuccessState extends ShopStates{
 ShopModel? model;
 ShopUserDataSuccessState({this.model});
}
class ShopUserDataLoadingState extends ShopStates{}
class ShopUpdateUserinfoLoadingState extends ShopStates{}
class ShopUserDataErrorState extends ShopStates{}
class ShopUpdateUserinfoErrorState extends ShopStates{}
class ShopUpdateUserinfoSuccessState extends ShopStates{
 ShopModel? model;
 ShopUpdateUserinfoSuccessState({this.model});
}
class ChangeImageSuccessState extends ShopStates {}
class ChangeImageErrorState extends ShopStates {}
class ShopChangeCartsSuccessState extends ShopStates{}
class ShopChangeCartsErrorState extends ShopStates{}
class ShopCartsSuccessState extends ShopStates{}
class ShopCartsLoadingState extends ShopStates{}
class ShopCartsErrorState extends ShopStates{}
