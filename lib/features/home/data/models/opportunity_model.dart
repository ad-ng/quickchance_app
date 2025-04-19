// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quickchance_app/features/auth/data/model/user_model.dart';

class OpportunityModel {
  int? id;
  String title;
  String description;
  String? location;
  String? deadline;
  int userId;
  String status;
  int categoryId;
  String? updatedAt;
  UserModel user;
  OpportunityModel({
    this.id,
    required this.title,
    required this.description,
    this.location,
    this.deadline,
    required this.userId,
    required this.status,
    required this.categoryId,
    this.updatedAt,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'deadline': deadline,
      'userId': userId,
      'status': status,
      'categoryId': categoryId,
      'updatedAt': updatedAt,
    };
  }

  factory OpportunityModel.fromMap(Map<String, dynamic> map) {
    return OpportunityModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
      location: map['location'] != null ? map['location'] as String : null,
      deadline: map['deadline'] != null ? map['deadline'] as String : null,
      userId: map['userId'] as int,
      status: map['status'] as String,
      categoryId: map['categoryId'] as int,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      user: UserModel.fromJson(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());
  factory OpportunityModel.fromJson(Map<String, dynamic> json) =>
      OpportunityModel.fromMap(json);
}
