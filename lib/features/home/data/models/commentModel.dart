// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quickchance_app/features/auth/data/model/user_model.dart';

class CommentModel {
  int? id;
  int oppId;
  String body;
  String? createdAt;
  UserModel? user;

  CommentModel({
    this.id,
    required this.oppId,
    required this.body,
    this.createdAt,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'oppId': oppId, 'body': body};
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as int,
      oppId: map['oppId'] as int,
      body: map['body'] as String,
      createdAt: map['createdAt'] as String,
      user: UserModel.fromJson(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
