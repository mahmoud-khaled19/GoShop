class HomeModelData {
  bool? status;
  HomeData? data;

  HomeModelData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach((element) {
        banners.add(BannersModel.fromJson(element));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((element) {
        products.add(ProductsModel.fromJson(element));
      });
    }
  }
}

class BannersModel {
  int? id;
  String? image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  int? id;

  dynamic? price;

  dynamic? oldPrice;

  dynamic discount;

  String? name;

  String? description;

  String? image;

  bool? favorite;

  bool? inCart;

  ProductsModel.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    favorite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
