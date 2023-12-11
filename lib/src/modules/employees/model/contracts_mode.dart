class ContractsEmpResponse {
  final List<ContractsEmp> data;
  final int status;
  final String message;

  ContractsEmpResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ContractsEmpResponse.fromJson(Map<String, dynamic> json) =>
      ContractsEmpResponse(
        data: List<ContractsEmp>.from(
            json["data"].map((x) => ContractsEmp.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class ContractsEmp {
  final String ctrCodigo;
  final String ctrNombre;

  ContractsEmp({
    required this.ctrCodigo,
    required this.ctrNombre,
  });

  factory ContractsEmp.fromJson(Map<String, dynamic> json) => ContractsEmp(
        ctrCodigo: json["ctr_codigo"],
        ctrNombre: json["ctr_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "ctr_codigo": ctrCodigo,
        "ctr_nombre": ctrNombre,
      };
}
