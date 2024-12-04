import 'dart:convert';

List<CatalogModel> catalogFromJson(String str) => List<CatalogModel>.from(
    json.decode(str).map((x) => CatalogModel.fromJson(x)));

String catalogToJson(List<CatalogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatalogModel {
  CatalogModel({required this.id, required this.title, required this.price});

  final String id;
  final String title;
  final String price;

  bool? isAddCard = false;

  factory CatalogModel.fromJson(Map<String, dynamic> json) =>
      CatalogModel(id: json["id"], title: json["title"], price: json["price"]);

  Map<String, dynamic> toJson() => {"id": id, "title": title, "price": price};
}
