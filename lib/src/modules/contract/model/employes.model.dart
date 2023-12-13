class EmployeesContractResponse {
  final List<EmployeesContract> data;
  final int status;
  final String message;

  EmployeesContractResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory EmployeesContractResponse.fromJson(Map<String, dynamic> json) =>
      EmployeesContractResponse(
        data: List<EmployeesContract>.from(
            json["data"].map((x) => EmployeesContract.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class EmployeesContract {
  final String empCodigo;
  final String empNombres;
  final String empApellidos;
  final String empCodigoEmp;

  EmployeesContract({
    required this.empCodigo,
    required this.empNombres,
    required this.empApellidos,
    required this.empCodigoEmp,
  });

  factory EmployeesContract.fromJson(Map<String, dynamic> json) =>
      EmployeesContract(
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
