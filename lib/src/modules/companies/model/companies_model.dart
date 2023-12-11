class CompaniesResponse {
  final List<Companie> data;
  final int status;
  final String message;

  CompaniesResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory CompaniesResponse.fromJson(Map<String, dynamic> json) =>
      CompaniesResponse(
        data:
            List<Companie>.from(json["data"].map((x) => Companie.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Companie {
  final String eprCodigo;
  final String eprNombre;
  final String eprDireccion;
  final String eprContactoNombre;
  final String eprContactoCorreo;
  final String eprContactoTelefono;
  final String eprUsrcrea;
  final String eprUsrmod;
  final DateTime eprFeccrea;
  final DateTime eprFecmod;
  final String eprEstado;
  final String eprCodusr;

  Companie({
    required this.eprCodigo,
    required this.eprNombre,
    required this.eprDireccion,
    required this.eprContactoNombre,
    required this.eprContactoCorreo,
    required this.eprContactoTelefono,
    required this.eprUsrcrea,
    required this.eprUsrmod,
    required this.eprFeccrea,
    required this.eprFecmod,
    required this.eprEstado,
    required this.eprCodusr,
  });

  factory Companie.fromJson(Map<String, dynamic> json) => Companie(
        eprCodigo: json["epr_codigo"],
        eprNombre: json["epr_nombre"],
        eprDireccion: json["epr_direccion"],
        eprContactoNombre: json["epr_contacto_nombre"],
        eprContactoCorreo: json["epr_contacto_correo"],
        eprContactoTelefono: json["epr_contacto_telefono"],
        eprUsrcrea: json["epr_usrcrea"],
        eprUsrmod: json["epr_usrmod"],
        eprFeccrea: DateTime.parse(json["epr_feccrea"]),
        eprFecmod: DateTime.parse(json["epr_fecmod"]),
        eprEstado: json["epr_estado"],
        eprCodusr: json["epr_codusr"] ?? '',
      );
  Map<String, dynamic> toJson() => {
        "epr_codigo": eprCodigo,
        "epr_nombre": eprNombre,
        "epr_direccion": eprDireccion,
        "epr_contacto_nombre": eprContactoNombre,
        "epr_contacto_correo": eprContactoCorreo,
        "epr_contacto_telefono": eprContactoTelefono,
        "epr_usrcrea": eprUsrcrea,
        "epr_usrmod": eprUsrmod,
        "epr_feccrea": eprFeccrea.toIso8601String(),
        "epr_fecmod": eprFecmod.toIso8601String(),
        "epr_estado": eprEstado,
        "epr_codusr": eprCodusr,
      };
}
