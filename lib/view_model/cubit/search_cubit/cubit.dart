import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/view_model/cubit/search_cubit/states.dart';
import '../../../app_constance/api_constance.dart';
import '../../../app_constance/constants_methods.dart';
import '../../shared/network/remote/dio.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(InitialSearchState());
 static SearchCubit get(context) => BlocProvider.of(context);
 SearchModel? model;
 void getSearch({
  required String text
}){
   emit(LoadingSearchState());
   DioHelper.postData(
       url: ApiConstance.search,
       data: {'text':text},
     token: AppMethods.token,

   ).then((value) {
     model =SearchModel.fromJson(value.data);
  print(model!.data);
     emit(SuccessSearchState());
   }).catchError((error){
     emit(ErrorSearchState());
     if (kDebugMode) {
       print(error.toString());
     }
   });

 }
}