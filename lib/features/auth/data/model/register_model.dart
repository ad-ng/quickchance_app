import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RegisterModel {
  String username;
  String email;
  String phoneNumber;
  String password;
  RegisterModel({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      username: map['username'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
