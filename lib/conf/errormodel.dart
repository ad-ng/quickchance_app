class ErrorModel {
  final List<String> message;
  final String error;
  final int statusCode;

  ErrorModel({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  // Modify fromJson to properly handle the data.
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: List<String>.from(json['message'] ?? []),
      error: json['error'] ?? 'Unknown Error',
      statusCode: json['statusCode'] ?? 500,
    );
  }
}
