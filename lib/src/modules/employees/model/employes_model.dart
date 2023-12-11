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
  final List<Employe> employes;
  final Pagination pagination;

  RespData({
    required this.employes,
    required this.pagination,
  });

  factory RespData.fromJson(Map<String, dynamic> json) => RespData(
        employes: List<Employe>.from(
            json["employes"].map((x) => Employe.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "employes": List<dynamic>.from(employes.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class Employe {
  final String empCodigo;
  final String empCodigoEmp;
  final String empFechaNacimiento;
  final String empNombres;
  final String empApellidos;
  final String empEstado;
  final DateTime empFeccrea;
  final DateTime empFecmod;
  final String empUsrcrea;
  final String empUsrmod;
  final String empCodgen;
  final String empCodemp;
  final String empCodubi;
  final String empCodcon;
  final MarGenGeneros marGenGeneros;
  final List<dynamic> marAsiAsignacion;
  final MarConContrataciones marConContrataciones;
  final MarUbiUbicaciones marUbiUbicaciones;

  Employe({
    required this.empCodigo,
    required this.empCodigoEmp,
    required this.empFechaNacimiento,
    required this.empNombres,
    required this.empApellidos,
    required this.empEstado,
    required this.empFeccrea,
    required this.empFecmod,
    required this.empUsrcrea,
    required this.empUsrmod,
    required this.empCodgen,
    required this.empCodemp,
    required this.empCodubi,
    required this.empCodcon,
    required this.marGenGeneros,
    required this.marAsiAsignacion,
    required this.marConContrataciones,
    required this.marUbiUbicaciones,
  });

  factory Employe.fromJson(Map<String, dynamic> json) => Employe(
        empCodigo: json["emp_codigo"],
        empCodigoEmp: json["emp_codigo_emp"],
        empFechaNacimiento: DateFormat("dd/MM/y")
            .format(DateTime.parse(json["emp_fecha_nacimiento"])),
        empNombres: json["emp_nombres"],
        empApellidos: json["emp_apellidos"],
        empEstado: json["emp_estado"],
        empFeccrea: DateTime.parse(json["emp_feccrea"]),
        empFecmod: DateTime.parse(json["emp_fecmod"]),
        empUsrcrea: json["emp_usrcrea"],
        empUsrmod: json["emp_usrmod"],
        empCodgen: json["emp_codgen"],
        empCodemp: json["emp_codemp"],
        empCodubi: json["emp_codubi"],
        empCodcon: json["emp_codcon"],
        marGenGeneros: MarGenGeneros.fromJson(json["mar_gen_generos"]),
        marAsiAsignacion:
            List<dynamic>.from(json["mar_asi_asignacion"].map((x) => x)),
        marConContrataciones:
            MarConContrataciones.fromJson(json["mar_con_contrataciones"]),
        marUbiUbicaciones:
            MarUbiUbicaciones.fromJson(json["mar_ubi_ubicaciones"]),
      );

  Map<String, dynamic> toJson() => {
        "emp_codigo": empCodigo,
        "emp_codigo_emp": empCodigoEmp,
        "emp_fecha_nacimiento": empFechaNacimiento,
        "emp_nombres": empNombres,
        "emp_apellidos": empApellidos,
        "emp_estado": empEstado,
        "emp_feccrea": empFeccrea.toIso8601String(),
        "emp_fecmod": empFecmod.toIso8601String(),
        "emp_usrcrea": empUsrcrea,
        "emp_usrmod": empUsrmod,
        "emp_codgen": empCodgen,
        "emp_codemp": empCodemp,
        "emp_codubi": empCodubi,
        "emp_codcon": empCodcon,
        "mar_gen_generos": marGenGeneros.toJson(),
        "mar_asi_asignacion":
            List<dynamic>.from(marAsiAsignacion.map((x) => x)),
        "mar_con_contrataciones": marConContrataciones.toJson(),
        "mar_ubi_ubicaciones": marUbiUbicaciones.toJson(),
      };
}

class MarConContrataciones {
  final String conCodigo;
  final String conNombre;
  final String conEstado;
  final DateTime conFeccrea;
  final DateTime conFecmod;
  final String conUsrcrea;
  final String conUsrmod;

  MarConContrataciones({
    required this.conCodigo,
    required this.conNombre,
    required this.conEstado,
    required this.conFeccrea,
    required this.conFecmod,
    required this.conUsrcrea,
    required this.conUsrmod,
  });

  factory MarConContrataciones.fromJson(Map<String, dynamic> json) =>
      MarConContrataciones(
        conCodigo: json["con_codigo"],
        conNombre: json["con_nombre"],
        conEstado: json["con_estado"],
        conFeccrea: DateTime.parse(json["con_feccrea"]),
        conFecmod: DateTime.parse(json["con_fecmod"]),
        conUsrcrea: json["con_usrcrea"],
        conUsrmod: json["con_usrmod"],
      );

  Map<String, dynamic> toJson() => {
        "con_codigo": conCodigo,
        "con_nombre": conNombre,
        "con_estado": conEstado,
        "con_feccrea": conFeccrea.toIso8601String(),
        "con_fecmod": conFecmod.toIso8601String(),
        "con_usrcrea": conUsrcrea,
        "con_usrmod": conUsrmod,
      };
}

class MarGenGeneros {
  final String genCodigo;
  final String genNombre;
  final String genEstado;
  final DateTime genFeccrea;
  final DateTime genFecmod;
  final String genUsrcrea;
  final String genUsrmod;

  MarGenGeneros({
    required this.genCodigo,
    required this.genNombre,
    required this.genEstado,
    required this.genFeccrea,
    required this.genFecmod,
    required this.genUsrcrea,
    required this.genUsrmod,
  });

  factory MarGenGeneros.fromJson(Map<String, dynamic> json) => MarGenGeneros(
        genCodigo: json["gen_codigo"],
        genNombre: json["gen_nombre"],
        genEstado: json["gen_estado"],
        genFeccrea: DateTime.parse(json["gen_feccrea"]),
        genFecmod: DateTime.parse(json["gen_fecmod"]),
        genUsrcrea: json["gen_usrcrea"],
        genUsrmod: json["gen_usrmod"],
      );

  Map<String, dynamic> toJson() => {
        "gen_codigo": genCodigo,
        "gen_nombre": genNombre,
        "gen_estado": genEstado,
        "gen_feccrea": genFeccrea.toIso8601String(),
        "gen_fecmod": genFecmod.toIso8601String(),
        "gen_usrcrea": genUsrcrea,
        "gen_usrmod": genUsrmod,
      };
}

class MarUbiUbicaciones {
  final String ubiCodigo;
  final String ubiNombre;
  final String ubiEstado;
  final DateTime ubiFeccrea;
  final DateTime ubiFecmod;
  final String ubiUsrcrea;
  final String ubiUsrmod;

  MarUbiUbicaciones({
    required this.ubiCodigo,
    required this.ubiNombre,
    required this.ubiEstado,
    required this.ubiFeccrea,
    required this.ubiFecmod,
    required this.ubiUsrcrea,
    required this.ubiUsrmod,
  });

  factory MarUbiUbicaciones.fromJson(Map<String, dynamic> json) =>
      MarUbiUbicaciones(
        ubiCodigo: json["ubi_codigo"],
        ubiNombre: json["ubi_nombre"],
        ubiEstado: json["ubi_estado"],
        ubiFeccrea: DateTime.parse(json["ubi_feccrea"]),
        ubiFecmod: DateTime.parse(json["ubi_fecmod"]),
        ubiUsrcrea: json["ubi_usrcrea"],
        ubiUsrmod: json["ubi_usrmod"],
      );

  Map<String, dynamic> toJson() => {
        "ubi_codigo": ubiCodigo,
        "ubi_nombre": ubiNombre,
        "ubi_estado": ubiEstado,
        "ubi_feccrea": ubiFeccrea.toIso8601String(),
        "ubi_fecmod": ubiFecmod.toIso8601String(),
        "ubi_usrcrea": ubiUsrcrea,
        "ubi_usrmod": ubiUsrmod,
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
