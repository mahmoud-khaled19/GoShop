import 'package:shop_app/models/shop_model/shop_model.dart';

abstract class LoginAppStates {}

class InitialLoginState extends LoginAppStates {}

class ChangePassVisibility extends LoginAppStates {}

class LoginLoadingState extends LoginAppStates {}

class LoginSuccessState extends LoginAppStates {
   final ShopModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginAppStates {
  late final String error;

  LoginErrorState(this.error);
}
