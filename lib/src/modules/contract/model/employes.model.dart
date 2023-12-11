class EmployesContractResponse {
  final List<EmployesContract> data;
  final int status;
  final String message;

  EmployesContractResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory EmployesContractResponse.fromJson(Map<String, dynamic> json) =>
      EmployesContractResponse(
        data: List<EmployesContract>.from(
            json["data"].map((x) => EmployesContract.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class EmployesContract {
  final String empCodigo;
  final String empNombres;
  final String empApellidos;
  final String empCodigoEmp;

  EmployesContract({
    required this.empCodigo,
    required this.empNombres,
    required this.empApellidos,
    required this.empCodigoEmp,
  });

  factory EmployesContract.fromJson(Map<String, dynamic> json) =>
      EmployesContract(
        empCodigo: json["emp_codigo"],
        empNombres: json["emp_nombres"],
        empApellidos: json["emp_apellidos"],
        empCodigoEmp: json["emp_codigo_emp"],
      );

  Map<String, dynamic> toJson() => {
        "emp_codigo": empCodigo,
        "emp_nombres": empNombres,
        "emp_apellidos": empApellidos,
        "emp_codigo_emp": empCodigoEmp,
      };
}
