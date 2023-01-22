class FavoritesModel {
  bool? status;
  FavData? data;
  String? message;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =json['message'];
    data = json['data'] != null ?  FavData.fromJson(json['data']) : null;
  }
}

class FavData {
  int? currentPage;
  List<DataModel> data=[];
  FavData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(DataModel.fromJson(v));
      });
    }
  }
}

class DataModel {
  int? id;
  ProductItem? product;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? ProductItem.fromJson(json['product']) : null;
  }
}

class ProductItem {
   int? id;
   dynamic price;
   dynamic oldPrice;
   dynamic discount;
   String? image;
   String? name;
   String? description;
  ProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}