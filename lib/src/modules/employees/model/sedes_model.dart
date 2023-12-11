class SedesResp {
  final List<Sede> data;
  final int status;
  final String message;

  SedesResp({
    required this.data,
    required this.status,
    required this.message,
  });

  factory SedesResp.fromJson(Map<String, dynamic> json) => SedesResp(
        data: List<Sede>.from(json["data"].map((x) => Sede.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Sede {
  final String ubiCodigo;
  final String ubiNombre;

  Sede({
    required this.ubiCodigo,
    required this.ubiNombre,
  });

  factory Sede.fromJson(Map<String, dynamic> json) => Sede(
        ubiCodigo: json["ubi_codigo"],
        ubiNombre: json["ubi_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "ubi_codigo": ubiCodigo,
        "ubi_nombre": ubiNombre,
      };
}
