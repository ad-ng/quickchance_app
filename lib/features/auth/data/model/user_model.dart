import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String? username;
  String? fullname;
  String? gender;
  String? email;
  bool? isVerified;
  String? password;
  String? location;
  List<String>? preferences;
  String? dob;
  String? role;
  String? phoneNumber;
  String? createdAt;
  UserModel({
    this.id,
    this.username,
    this.fullname,
    this.gender,
    this.email,
    this.isVerified,
    this.password,
    this.location,
    this.preferences,
    this.dob,
    this.role,
    this.phoneNumber,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'fullname': fullname,
      'gender': gender,
      'email': email,
      'isVerified': isVerified,
      'password': password,
      'location': location,
      'preferences': preferences,
      'dob': dob,
      'role': role,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      isVerified: map['isVerified'] != null ? map['isVerified'] as bool : null,
      password: map['password'] != null ? map['password'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      preferences:
          map['preferences'] != null
              ? List<String>.from(map['preferences'] as List)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
