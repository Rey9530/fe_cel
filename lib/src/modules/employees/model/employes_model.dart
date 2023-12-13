import 'package:intl/intl.dart';

class EmployesResponse {
  final RespData data;
  final int status;
  final String message;

  EmployesResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory EmployesResponse.fromJson(Map<String, dynamic> json) =>
      EmployesResponse(
        data: RespData.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class RespData {
  final List<Employee> employes;
  final Pagination pagination;

  RespData({
    required this.employes,
    required this.pagination,
  });

  factory RespData.fromJson(Map<String, dynamic> json) => RespData(
        employes: List<Employee>.from(
            json["employes"].map((x) => Employee.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "employes": List<dynamic>.from(employes.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class Employee {
  final String empCodigo;
  final String empCodigoEmp;
  final String empBirthDate;
  final String empNombres;
  final String empApellidos;
  final String empStatus;
  final DateTime empFecCreate;
  final DateTime empFecUpdate;
  final String empUsrCreate;
  final String empUsrUpdate;
  final String empCodGen;
  final String empCodEmp;
  final String empCodUbi;
  final String empCodCon;
  final MarGenGenders marGenGenders;
  final List<dynamic> marAsiAssignation;
  final MarConContractions marConContractions;
  final MarUbiLocations marUbiLocations;

  Employee({
    required this.empCodigo,
    required this.empCodigoEmp,
    required this.empBirthDate,
    required this.empNombres,
    required this.empApellidos,
    required this.empStatus,
    required this.empFecCreate,
    required this.empFecUpdate,
    required this.empUsrCreate,
    required this.empUsrUpdate,
    required this.empCodGen,
    required this.empCodEmp,
    required this.empCodUbi,
    required this.empCodCon,
    required this.marGenGenders,
    required this.marAsiAssignation,
    required this.marConContractions,
    required this.marUbiLocations,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        empCodigo: json["emp_codigo"],
        empCodigoEmp: json["emp_codigo_emp"],
        empBirthDate: DateFormat("dd/MM/y")
            .format(DateTime.parse(json["emp_fecha_nacimiento"])),
        empNombres: json["emp_nombres"],
        empApellidos: json["emp_apellidos"],
        empStatus: json["emp_estado"],
        empFecCreate: DateTime.parse(json["emp_feccrea"]),
        empFecUpdate: DateTime.parse(json["emp_fecmod"]),
        empUsrCreate: json["emp_usrcrea"],
        empUsrUpdate: json["emp_usrmod"],
        empCodGen: json["emp_codgen"],
        empCodEmp: json["emp_codemp"],
        empCodUbi: json["emp_codubi"],
        empCodCon: json["emp_codcon"],
        marGenGenders: MarGenGenders.fromJson(json["mar_gen_generos"]),
        marAsiAssignation:
            List<dynamic>.from(json["mar_asi_asignacion"].map((x) => x)),
        marConContractions:
            MarConContractions.fromJson(json["mar_con_contrataciones"]),
        marUbiLocations: MarUbiLocations.fromJson(json["mar_ubi_ubicaciones"]),
      );

  Map<String, dynamic> toJson() => {
        "emp_codigo": empCodigo,
        "emp_codigo_emp": empCodigoEmp,
        "emp_fecha_nacimiento": empBirthDate,
        "emp_nombres": empNombres,
        "emp_apellidos": empApellidos,
        "emp_estado": empStatus,
        "emp_feccrea": empFecCreate.toIso8601String(),
        "emp_fecmod": empFecUpdate.toIso8601String(),
        "emp_usrcrea": empUsrCreate,
        "emp_usrmod": empUsrUpdate,
        "emp_codgen": empCodGen,
        "emp_codemp": empCodEmp,
        "emp_codubi": empCodUbi,
        "emp_codcon": empCodCon,
        "mar_gen_generos": marGenGenders.toJson(),
        "mar_asi_asignacion":
            List<dynamic>.from(marAsiAssignation.map((x) => x)),
        "mar_con_contrataciones": marConContractions.toJson(),
        "mar_ubi_ubicaciones": marUbiLocations.toJson(),
      };
}

class MarConContractions {
  final String conCodigo;
  final String conNombre;
  final String conStatus;
  final DateTime conFecCreate;
  final DateTime conFecUpdate;
  final String conUsrCreate;
  final String conUsrUpdate;

  MarConContractions({
    required this.conCodigo,
    required this.conNombre,
    required this.conStatus,
    required this.conFecCreate,
    required this.conFecUpdate,
    required this.conUsrCreate,
    required this.conUsrUpdate,
  });

  factory MarConContractions.fromJson(Map<String, dynamic> json) =>
      MarConContractions(
        conCodigo: json["con_codigo"],
        conNombre: json["con_nombre"],
        conStatus: json["con_estado"],
        conFecCreate: DateTime.parse(json["con_feccrea"]),
        conFecUpdate: DateTime.parse(json["con_fecmod"]),
        conUsrCreate: json["con_usrcrea"],
        conUsrUpdate: json["con_usrmod"],
      );

  Map<String, dynamic> toJson() => {
        "con_codigo": conCodigo,
        "con_nombre": conNombre,
        "con_estado": conStatus,
        "con_feccrea": conFecCreate.toIso8601String(),
        "con_fecmod": conFecUpdate.toIso8601String(),
        "con_usrcrea": conUsrCreate,
        "con_usrmod": conUsrUpdate,
      };
}

class MarGenGenders {
  final String genCodigo;
  final String genNombre;
  final String genStatus;
  final DateTime genFecCreate;
  final DateTime genFecUpdate;
  final String genUsrCreate;
  final String genUsrUpdate;

  MarGenGenders({
    required this.genCodigo,
    required this.genNombre,
    required this.genStatus,
    required this.genFecCreate,
    required this.genFecUpdate,
    required this.genUsrCreate,
    required this.genUsrUpdate,
  });

  factory MarGenGenders.fromJson(Map<String, dynamic> json) => MarGenGenders(
        genCodigo: json["gen_codigo"],
        genNombre: json["gen_nombre"],
        genStatus: json["gen_estado"],
        genFecCreate: DateTime.parse(json["gen_feccrea"]),
        genFecUpdate: DateTime.parse(json["gen_fecmod"]),
        genUsrCreate: json["gen_usrcrea"],
        genUsrUpdate: json["gen_usrmod"],
      );

  Map<String, dynamic> toJson() => {
        "gen_codigo": genCodigo,
        "gen_nombre": genNombre,
        "gen_estado": genStatus,
        "gen_feccrea": genFecCreate.toIso8601String(),
        "gen_fecmod": genFecUpdate.toIso8601String(),
        "gen_usrcrea": genUsrCreate,
        "gen_usrmod": genUsrUpdate,
      };
}

class MarUbiLocations {
  final String ubiCodigo;
  final String ubiNombre;
  final String ubiStatus;
  final DateTime ubiFecCreate;
  final DateTime ubiFecUpdate;
  final String ubiUsrCreate;
  final String ubiUsrUpdate;

  MarUbiLocations({
    required this.ubiCodigo,
    required this.ubiNombre,
    required this.ubiStatus,
    required this.ubiFecCreate,
    required this.ubiFecUpdate,
    required this.ubiUsrCreate,
    required this.ubiUsrUpdate,
  });

  factory MarUbiLocations.fromJson(Map<String, dynamic> json) =>
      MarUbiLocations(
        ubiCodigo: json["ubi_codigo"],
        ubiNombre: json["ubi_nombre"],
        ubiStatus: json["ubi_estado"],
        ubiFecCreate: DateTime.parse(json["ubi_feccrea"]),
        ubiFecUpdate: DateTime.parse(json["ubi_fecmod"]),
        ubiUsrCreate: json["ubi_usrcrea"],
        ubiUsrUpdate: json["ubi_usrmod"],
      );

  Map<String, dynamic> toJson() => {
        "ubi_codigo": ubiCodigo,
        "ubi_nombre": ubiNombre,
        "ubi_estado": ubiStatus,
        "ubi_feccrea": ubiFecCreate.toIso8601String(),
        "ubi_fecmod": ubiFecUpdate.toIso8601String(),
        "ubi_usrcrea": ubiUsrCreate,
        "ubi_usrmod": ubiUsrUpdate,
      };
}

class Pagination {
  final int page;
  final int quantity;
  final int total;

  Pagination({
    required this.page,
    required this.quantity,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        quantity: json["quantity"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "quantity": quantity,
        "total": total,
      };
}
