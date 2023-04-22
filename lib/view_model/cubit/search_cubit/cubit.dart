import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/view_model/cubit/search_cubit/states.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
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