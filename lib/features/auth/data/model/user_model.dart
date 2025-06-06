class UserModel {
  int id;
  String? fullname;
  String? username;
  String? email;
  String? gender;
  String? location;
  String? dob;
  String? phoneNumber;
  String? profileImg;
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
    this.location,
    this.dob,
    this.phoneNumber,
    this.profileImg,
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
      location: json['location'] ?? 'Not Provided',
      dob: json['dob'] ?? '1993-02-03T02:43:41.238Z',
      phoneNumber: json['phoneNumber'] ?? 'Unknown',
      profileImg:
          json['profileImg'] ??
          'https://static1.cbrimages.com/wordpress/wp-content/uploads/2024/12/15-best-character-arcs-in-avatar-the-last-airbender-ranked.jpg',
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
      'location': location ?? 'Not Provided',
      'dob': dob ?? '1993-02-03T02:43:41.238Z',
      'phoneNumber': phoneNumber ?? 'Unknown',
      'profileImg':
          profileImg ??
          'https://static1.cbrimages.com/wordpress/wp-content/uploads/2024/12/15-best-character-arcs-in-avatar-the-last-airbender-ranked.jpg',
      //'coverImg': coverImg ?? 'default_cover.png',
      'role': role ?? 'user',
      'isVerified': isVerified,
      'createdAt': createdAt,
    };
  }
}
