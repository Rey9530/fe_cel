class HoursCtrResponse {
  final List<HoursCtr> data;
  final int status;
  final String message;

  HoursCtrResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory HoursCtrResponse.fromJson(Map<String, dynamic> json) =>
      HoursCtrResponse(
        data:
            List<HoursCtr>.from(json["data"].map((x) => HoursCtr.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class HoursCtr {
  final String horCodigo;
  final String horNombre;

  HoursCtr({
    required this.horCodigo,
    required this.horNombre,
  });

  factory HoursCtr.fromJson(Map<String, dynamic> json) => HoursCtr(
        horCodigo: json["hor_codigo"],
        horNombre: json["hor_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "hor_codigo": horCodigo,
        "hor_nombre": horNombre,
      };
}
