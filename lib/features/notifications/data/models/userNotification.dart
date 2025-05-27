import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserNotification {
  int? id;
  int userId;
  int notificationId;
  bool isRead;
  bool isLocalSent;
  String createdAt;
  UserNotification({
    this.id,
    required this.userId,
    required this.notificationId,
    required this.isRead,
    required this.isLocalSent,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'notificationId': notificationId,
      'isRead': isRead,
      'isLocalSent': isLocalSent,
      'createdAt': createdAt,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserNotification.fromJson(String source) =>
      UserNotification.fromMap(json.decode(source) as Map<String, dynamic>);
}
