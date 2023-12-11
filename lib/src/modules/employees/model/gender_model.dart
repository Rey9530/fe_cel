class GenderResp {
  final List<Gender> data;
  final int status;
  final String message;

  GenderResp({
    required this.data,
    required this.status,
    required this.message,
  });

  factory GenderResp.fromJson(Map<String, dynamic> json) => GenderResp(
        data: List<Gender>.from(json["data"].map((x) => Gender.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Gender {
  final String genCodigo;
  final String genNombre;

  Gender({
    required this.genCodigo,
    required this.genNombre,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        genCodigo: json["gen_codigo"],
        genNombre: json["gen_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "gen_codigo": genCodigo,
        "gen_nombre": genNombre,
      };
}
