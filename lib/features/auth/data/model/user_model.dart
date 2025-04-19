class UserModel {
  int id;
  String? fullname;
  String? username;
  String? email;
  String? gender;
  String? address;
  String? dob;
  String? phoneNumber;
  //  String? profileImg;
  // String? coverImg;
  String? role;
  bool isVerified;
  String createdAt;

  UserModel({
    required this.id,
    this.fullname,
    this.username,
    this.email,
    this.gender,
    this.address,
    this.dob,
    this.phoneNumber,
    // this.profileImg,
    // this.coverImg,
    this.role,
    required this.isVerified,
    required this.createdAt,
  });

  // Convert JSON to UserModel, with null checking and handling default values
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullname: json['fullname'] ?? 'Unknown', // Default value if null
      username: json['username'] ?? 'Unknown',
      email: json['email'] ?? 'unknown@example.com',
      gender: json['gender'] ?? 'Not Specified',
      address: json['address'] ?? 'Not Provided',
      dob: json['dob'] ?? '1993-02-03T02:43:41.238Z',
      phoneNumber: json['phoneNumber'] ?? 'Unknown',
      // profileImg: json['profileImg'] ?? 'default_profile.png',
      // coverImg: json['coverImg'] ?? 'default_cover.png',
      role: json['role'] ?? 'user', // Default role
      isVerified: json['isVerified'] ?? false, // Default value for boolean
      createdAt: json['createdAt'] ?? 'Unknown',
    );
  }

  // Convert UserModel to JSON, ensuring no null values are passed
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname ?? 'Unknown',
      'username': username ?? 'Unknown',
      'email': email ?? 'unknown@example.com',
      'gender': gender ?? 'Not Specified',
      'address': address ?? 'Not Provided',
      'dob': dob ?? '1993-02-03T02:43:41.238Z',
      'phoneNumber': phoneNumber ?? 'Unknown',
      // 'profileImg': profileImg ?? 'default_profile.png',
      //'coverImg': coverImg ?? 'default_cover.png',
      'role': role ?? 'user',
      'isVerified': isVerified,
      'createdAt': createdAt,
    };
  }
}
