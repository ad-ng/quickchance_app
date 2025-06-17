// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quickchance_app/features/search/data/models/categoryModel.dart';

class PreferenceModel {
  int id;
  int userId;
  int categoryId;
  CategoryModel category;
  PreferenceModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'categoryId': categoryId,
      'category': category.toMap(),
    };
  }

  factory PreferenceModel.fromMap(Map<String, dynamic> map) {
    return PreferenceModel(
      id: map['id'] as int,
      userId: map['userId'] as int,
      categoryId: map['categoryId'] as int,
      category: CategoryModel.fromMap(map['category'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PreferenceModel.fromJson(String source) =>
      PreferenceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
