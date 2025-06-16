import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddUserModel {
  String username;
  String fullname;
  String email;
  String gender;
  String role;
  AddUserModel({
    required this.username,
    required this.fullname,
    required this.email,
    required this.gender,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'fullname': fullname,
      'email': email,
      'gender': gender,
      'role': role,
    };
  }

  factory AddUserModel.fromMap(Map<String, dynamic> map) {
    return AddUserModel(
      username: map['username'] as String,
      fullname: map['fullname'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddUserModel.fromJson(String source) =>
      AddUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
