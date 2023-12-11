class GenerateCodeResp {
  final Data data;
  final int status;
  final String message;

  GenerateCodeResp({
    required this.data,
    required this.status,
    required this.message,
  });

  factory GenerateCodeResp.fromJson(Map<String, dynamic> json) =>
      GenerateCodeResp(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  final String code;

  Data({
    required this.code,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}
