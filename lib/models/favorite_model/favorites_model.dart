class FavoritesModel{
  late final bool status ;
  late final String message ;
  FavoritesModel.fromJson(Map<String,dynamic>json){
    status =json['status'];
    message =json['message'];
  }
}