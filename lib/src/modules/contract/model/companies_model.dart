class CompaniesResponse {
  final List<ContractCompanies> data;
  final int status;
  final String message;

  CompaniesResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory CompaniesResponse.fromJson(Map<String, dynamic> json) =>
      CompaniesResponse(
        data: List<ContractCompanies>.from(
            json["data"].map((x) => ContractCompanies.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class ContractCompanies {
  final String eprCodigo;
  final String eprNombre;

  ContractCompanies({
    required this.eprCodigo,
    required this.eprNombre,
  });

  factory ContractCompanies.fromJson(Map<String, dynamic> json) =>
      ContractCompanies(
        eprCodigo: json["epr_codigo"],
        eprNombre: json["epr_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "epr_codigo": eprCodigo,
        "epr_nombre": eprNombre,
      };
}
