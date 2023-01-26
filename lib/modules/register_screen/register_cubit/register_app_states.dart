import 'package:shop_app/models/register_model/register_model.dart';

abstract class RegisterAppStates {}

class InitialRegisterState extends RegisterAppStates {}

class ChangePassVisibilityForRegister extends RegisterAppStates {}

class RegisterLoadingState extends RegisterAppStates {}

class RegisterSuccessState extends RegisterAppStates {
   final RegisterModel model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterAppStates {
  late final String error;

  RegisterErrorState(this.error);
}
