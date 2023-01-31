import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/search_screen/search_cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

import '../../../shared/components/constants.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(InitialSearchState());
 static SearchCubit get(context) => BlocProvider.of(context);
 SearchModel? model;
 void getSearch({
  required String text
}){
   emit(LoadingSearchState());
   DioHelper.postData(
       url: search,
       data: {'text':text},
     token: token,

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