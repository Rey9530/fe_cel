class EmployesScheduleResponse {
  final List<EmpSchedule> data;
  final int status;
  final String message;

  EmployesScheduleResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory EmployesScheduleResponse.fromJson(Map<String, dynamic> json) =>
      EmployesScheduleResponse(
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
  final MarEmpEmpleados marEmpEmpleados;

  EmpSchedule({
    required this.asiCodhor,
    required this.asiCodigo,
    required this.marEmpEmpleados,
  });

  factory EmpSchedule.fromJson(Map<String, dynamic> json) => EmpSchedule(
        asiCodhor: json["asi_codhor"],
        asiCodigo: json["asi_codigo"],
        marEmpEmpleados: MarEmpEmpleados.fromJson(json["mar_emp_empleados"]),
      );

  Map<String, dynamic> toJson() => {
        "asi_codhor": asiCodhor,
        "asi_codigo": asiCodigo,
        "mar_emp_empleados": marEmpEmpleados.toJson(),
      };
}

class MarEmpEmpleados {
  final String empNombres;
  final String empApellidos;
  final String empCodigo;
  final String empCodigoEmp;
  final MarUbiUbicaciones marUbiUbicaciones;
  final MarConContrataciones marConContrataciones;

  MarEmpEmpleados({
    required this.empNombres,
    required this.empApellidos,
    required this.empCodigo,
    required this.empCodigoEmp,
    required this.marUbiUbicaciones,
    required this.marConContrataciones,
  });

  factory MarEmpEmpleados.fromJson(Map<String, dynamic> json) =>
      MarEmpEmpleados(
        empNombres: json["emp_nombres"],
        empApellidos: json["emp_apellidos"],
        empCodigo: json["emp_codigo"],
        empCodigoEmp: json["emp_codigo_emp"],
        marUbiUbicaciones:
            MarUbiUbicaciones.fromJson(json["mar_ubi_ubicaciones"]),
        marConContrataciones:
            MarConContrataciones.fromJson(json["mar_con_contrataciones"]),
      );

  Map<String, dynamic> toJson() => {
        "emp_nombres": empNombres,
        "emp_apellidos": empApellidos,
        "emp_codigo": empCodigo,
        "emp_codigo_emp": empCodigoEmp,
        "mar_ubi_ubicaciones": marUbiUbicaciones.toJson(),
        "mar_con_contrataciones": marConContrataciones.toJson(),
      };
}

class MarConContrataciones {
  final String conNombre;

  MarConContrataciones({
    required this.conNombre,
  });

  factory MarConContrataciones.fromJson(Map<String, dynamic> json) =>
      MarConContrataciones(
        conNombre: json["con_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "con_nombre": conNombre,
      };
}

class MarUbiUbicaciones {
  final String ubiNombre;

  MarUbiUbicaciones({
    required this.ubiNombre,
  });

  factory MarUbiUbicaciones.fromJson(Map<String, dynamic> json) =>
      MarUbiUbicaciones(
        ubiNombre: json["ubi_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "ubi_nombre": ubiNombre,
      };
}
