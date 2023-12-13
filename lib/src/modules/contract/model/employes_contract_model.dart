class EmployeesScheduleResponse {
  final List<EmpSchedule> data;
  final int status;
  final String message;

  EmployeesScheduleResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory EmployeesScheduleResponse.fromJson(Map<String, dynamic> json) =>
      EmployeesScheduleResponse(
        data: List<EmpSchedule>.from(
            json["data"].map((x) => EmpSchedule.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class EmpSchedule {
  final String asiCodhor;
  final String asiCodigo;
  final MarEmpEmployees marEmpEmployees;

  EmpSchedule({
    required this.asiCodhor,
    required this.asiCodigo,
    required this.marEmpEmployees,
  });

  factory EmpSchedule.fromJson(Map<String, dynamic> json) => EmpSchedule(
        asiCodhor: json["asi_codhor"],
        asiCodigo: json["asi_codigo"],
        marEmpEmployees: MarEmpEmployees.fromJson(json["mar_emp_empleados"]),
      );

  Map<String, dynamic> toJson() => {
        "asi_codhor": asiCodhor,
        "asi_codigo": asiCodigo,
        "mar_emp_empleados": marEmpEmployees.toJson(),
      };
}

class MarEmpEmployees {
  final String empNombres;
  final String empSurnames;
  final String empCodigo;
  final String empCodigoEmp;
  final MarUbiLocations marUbiLocations;
  final MarConHiring marConHiring;

  MarEmpEmployees({
    required this.empNombres,
    required this.empSurnames,
    required this.empCodigo,
    required this.empCodigoEmp,
    required this.marUbiLocations,
    required this.marConHiring,
  });

  factory MarEmpEmployees.fromJson(Map<String, dynamic> json) =>
      MarEmpEmployees(
        empNombres: json["emp_nombres"],
        empSurnames: json["emp_apellidos"],
        empCodigo: json["emp_codigo"],
        empCodigoEmp: json["emp_codigo_emp"],
        marUbiLocations: MarUbiLocations.fromJson(json["mar_ubi_ubicaciones"]),
        marConHiring: MarConHiring.fromJson(json["mar_con_contrataciones"]),
      );

  Map<String, dynamic> toJson() => {
        "emp_nombres": empNombres,
        "emp_apellidos": empSurnames,
        "emp_codigo": empCodigo,
        "emp_codigo_emp": empCodigoEmp,
        "mar_ubi_ubicaciones": marUbiLocations.toJson(),
        "mar_con_contrataciones": marConHiring.toJson(),
      };
}

class MarConHiring {
  final String conNames;

  MarConHiring({
    required this.conNames,
  });

  factory MarConHiring.fromJson(Map<String, dynamic> json) => MarConHiring(
        conNames: json["con_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "con_nombre": conNames,
      };
}

class MarUbiLocations {
  final String ubiNames;

  MarUbiLocations({
    required this.ubiNames,
  });

  factory MarUbiLocations.fromJson(Map<String, dynamic> json) =>
      MarUbiLocations(
        ubiNames: json["ubi_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "ubi_nombre": ubiNames,
      };
}
