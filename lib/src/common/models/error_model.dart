class ErrorResponse {
  final DateTime time;
  final String path;
  final dynamic data;
  final String message;
  final int status;

  ErrorResponse({
    required this.time,
    required this.path,
    required this.data,
    required this.message,
    required this.status,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        time: DateTime.parse(json["time"]),
        path: json["path"] ?? '',
        data: json["data"] ?? '',
        message: json["message"] ?? '',
        status: json["status"] ?? 500,
      );
}
