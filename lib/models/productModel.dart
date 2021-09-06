import 'dart:io';

class ProductModel {
  List<File>? imageSrc;
  String? name;
  String? description;
  int? currentPrice;
  int? oldPrice;
  int? quantity;
  bool? inCart;
  bool? isFav;

  ProductModel({
    required this.imageSrc,
    required this.name,
    required this.description,
    required this.currentPrice,
    this.oldPrice = 0,
    this.quantity = 0,
    this.inCart = false,
    this.isFav = false,
  });
}
