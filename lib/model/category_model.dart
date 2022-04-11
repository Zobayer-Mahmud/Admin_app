// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CategoryModel {
  CategoryModel({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.icon,
  });

  int? id;
  String? name;
  String? image;
  String? icon;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        icon: json["icon"] == null ? null : json["icon"],
      );
}
