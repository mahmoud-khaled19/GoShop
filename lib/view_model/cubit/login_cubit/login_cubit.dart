import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/api_constance.dart';
import '../../../../models/shop_model/shop_model.dart';
import '../../shared/network/remote/dio.dart';
import 'login_app_states.dart';

class LoginCubit extends Cubit<LoginAppStates> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool isVisible = true;
  late ShopModel loginModel;

  void changePassVisibility() {
    isVisible = !isVisible;
    emit(ChangePassVisibility());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: ApiConstance.login, data: {'email': email, 'password': password})
        .then((value) {
      loginModel = ShopModel.fromJson(value.data);
      if (kDebugMode) {
        print(value.data);
      }
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
