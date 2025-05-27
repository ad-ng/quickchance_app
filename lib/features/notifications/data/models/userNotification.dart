import 'dart:convert';

import 'package:quickchance_app/features/notifications/data/models/eachnotification_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserNotification {
  int? id;
  int userId;
  int notificationId;
  bool isRead;
  bool isLocalSent;
  String createdAt;
  EachNotificationModel notification;
  UserNotification({
    this.id,
    required this.userId,
    required this.notificationId,
    required this.isRead,
    required this.isLocalSent,
    required this.createdAt,
    required this.notification,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'notificationId': notificationId,
      'isRead': isRead,
      'isLocalSent': isLocalSent,
      'createdAt': createdAt,
      'notification': notification.toMap(),
    };
  }

  factory UserNotification.fromMap(Map<String, dynamic> map) {
    return UserNotification(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] as int,
      notificationId: map['notificationId'] as int,
      isRead: map['isRead'] as bool,
      isLocalSent: map['isLocalSent'] as bool,
      createdAt: map['createdAt'] as String,
      notification: EachNotificationModel.fromMap(
        map['notification'] as Map<String, dynamic>,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserNotification.fromJson(String source) =>
      UserNotification.fromMap(json.decode(source) as Map<String, dynamic>);
}
