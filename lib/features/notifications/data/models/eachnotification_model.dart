import 'dart:convert';

import 'package:quickchance_app/features/home/data/models/opportunity_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EachNotificationModel {
  int? id;
  int? opportunityId;
  int? categoryId;
  String title;
  String body;
  String? createdAt;
  OpportunityModel? opportunity;
  EachNotificationModel({
    this.id,
    this.opportunityId,
    this.categoryId,
    required this.title,
    required this.body,
    this.createdAt,
    this.opportunity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'opportunityId': opportunityId,
      'categoryId': categoryId,
      'title': title,
      'body': body,
      'createdAt': createdAt,
      'opportunity': opportunity?.toMap(),
    };
  }

  factory EachNotificationModel.fromMap(Map<String, dynamic> map) {
    return EachNotificationModel(
      id: map['id'] != null ? map['id'] as int : null,
      opportunityId:
          map['opportunityId'] != null ? map['opportunityId'] as int : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      title: map['title'] as String,
      body: map['body'] as String,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      opportunity:
          map['opportunity'] != null && map['opportunity'] is Map
              ? OpportunityModel.fromMap(
                Map<String, dynamic>.from(map['opportunity']),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EachNotificationModel.fromJson(String source) =>
      EachNotificationModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
