// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateUserModel {
  String? fullname;
  String? username;
  String? gender;
  String? location;
  String? dob;
  String? phoneNumber;

  UpdateUserModel({
    this.fullname,
    this.username,
    this.gender,
    this.location,
    this.dob,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullname': fullname,
      'username': username,
      'gender': gender,
      'location': location,
      'dob': dob,
      'phoneNumber': phoneNumber,
    };
  }

  factory UpdateUserModel.fromMap(Map<String, dynamic> map) {
    return UpdateUserModel(
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateUserModel.fromJson(String source) =>
      UpdateUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
