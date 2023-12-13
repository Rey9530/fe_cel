class CompaniesResponse {
  final List<Company> data;
  final int status;
  final String message;

  CompaniesResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory CompaniesResponse.fromJson(Map<String, dynamic> json) =>
      CompaniesResponse(
        data: List<Company>.from(json["data"].map((x) => Company.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Company {
  final String eprCode;
  final String eprName;
  final String eprAddress;
  final String eprContactName;
  final String eprContactEmail;
  final String eprContactPhone;
  final String eprUsrCreate;
  final String eprUsrUpdate;
  final DateTime eprFecCreate;
  final DateTime eprFecUpdate;
  final String eprStatus;
  final String eprCodUsr;

  Company({
    required this.eprCode,
    required this.eprName,
    required this.eprAddress,
    required this.eprContactName,
    required this.eprContactEmail,
    required this.eprContactPhone,
    required this.eprUsrCreate,
    required this.eprUsrUpdate,
    required this.eprFecCreate,
    required this.eprFecUpdate,
    required this.eprStatus,
    required this.eprCodUsr,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        eprCode: json["epr_codigo"],
        eprName: json["epr_nombre"],
        eprAddress: json["epr_direccion"],
        eprContactName: json["epr_contacto_nombre"],
        eprContactEmail: json["epr_contacto_correo"],
        eprContactPhone: json["epr_contacto_telefono"],
        eprUsrCreate: json["epr_usrcrea"],
        eprUsrUpdate: json["epr_usrmod"],
        eprFecCreate: DateTime.parse(json["epr_feccrea"]),
        eprFecUpdate: DateTime.parse(json["epr_fecmod"]),
        eprStatus: json["epr_estado"],
        eprCodUsr: json["epr_codusr"] ?? '',
      );
  Map<String, dynamic> toJson() => {
        "epr_codigo": eprCode,
        "epr_nombre": eprName,
        "epr_direccion": eprAddress,
        "epr_contacto_nombre": eprContactName,
        "epr_contacto_correo": eprContactEmail,
        "epr_contacto_telefono": eprContactPhone,
        "epr_usrcrea": eprUsrCreate,
        "epr_usrmod": eprUsrUpdate,
        "epr_feccrea": eprFecCreate.toIso8601String(),
        "epr_fecmod": eprFecUpdate.toIso8601String(),
        "epr_estado": eprStatus,
        "epr_codusr": eprCodUsr,
      };
}
