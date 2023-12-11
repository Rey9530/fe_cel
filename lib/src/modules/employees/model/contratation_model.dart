class ContratationResp {
  final List<Contratation> data;
  final int status;
  final String message;

  ContratationResp({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ContratationResp.fromJson(Map<String, dynamic> json) =>
      ContratationResp(
        data: List<Contratation>.from(
            json["data"].map((x) => Contratation.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Contratation {
  final String conCodigo;
  final String conNombre;

  Contratation({
    required this.conCodigo,
    required this.conNombre,
  });

  factory Contratation.fromJson(Map<String, dynamic> json) => Contratation(
        conCodigo: json["con_codigo"],
        conNombre: json["con_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "con_codigo": conCodigo,
        "con_nombre": conNombre,
      };
}
