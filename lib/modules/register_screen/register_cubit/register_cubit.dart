import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model/register_model.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_app_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import '../../../shared/network/remote/dio.dart';

class RegisterCubit extends Cubit<RegisterAppStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  bool visible = true;
  RegisterModel? registerModel;

  void changePassVisibility() {
    visible = !visible;
    emit(ChangePassVisibilityForRegister());
  }

  void userRegister({
    required String email,
    String? image,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: register,
        data: {
          'email': email, 'password': password,
          'name': name, 'phone': phone,'image':image
        })
        .then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      if (kDebugMode) {
           print(value.data);
      }
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      if (kDebugMode) {
        print(error);
      }
    });
  }

}
