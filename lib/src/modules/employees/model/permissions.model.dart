import 'package:intl/intl.dart';

class PermissionsResp {
  List<PermissionsItem> data;
  int status;
  String message;

  PermissionsResp({
    required this.data,
    required this.status,
    required this.message,
  });

  factory PermissionsResp.fromJson(Map<String, dynamic> json) =>
      PermissionsResp(
        data: List<PermissionsItem>.from(
            json["data"].map((x) => PermissionsItem.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );
}

class PermissionsItem {
  String perCodigo;
  String perCodasi;
  String perCodemp;
  String perCodempReemplazo;
  String perCodmop;
  String perFechaInicio;
  String perFechaFin;
  String perComentario;
  String perEstado;
  DateTime perFeccrea;
  DateTime perFecmod;
  String perUsrcrea;
  String perUsrmod;
  MarEmpEmpleadoReemplazo marEmpEmpleadoReemplazo;
  MarMopMotivoPer marMopMotivoPer;

  PermissionsItem({
    required this.perCodigo,
    required this.perCodasi,
    required this.perCodemp,
    required this.perCodempReemplazo,
    required this.perCodmop,
    required this.perFechaInicio,
    required this.perFechaFin,
    required this.perComentario,
    required this.perEstado,
    required this.perFeccrea,
    required this.perFecmod,
    required this.perUsrcrea,
    required this.perUsrmod,
    required this.marEmpEmpleadoReemplazo,
    required this.marMopMotivoPer,
  });

  factory PermissionsItem.fromJson(Map<String, dynamic> json) =>
      PermissionsItem(
        perCodigo: json["per_codigo"],
        perCodasi: json["per_codasi"],
        perCodemp: json["per_codemp"],
        perCodempReemplazo: json["per_codemp_reemplazo"],
        perCodmop: json["per_codmop"],
        perFechaInicio: DateFormat("dd/MM/y")
            .format(DateTime.parse(json["per_fecha_inicio"])),
        perFechaFin:
            DateFormat("dd/MM/y").format(DateTime.parse(json["per_fecha_fin"])),
        perComentario: json["per_comentario"],
        perEstado: json["per_estado"],
        perFeccrea: DateTime.parse(json["per_feccrea"]),
        perFecmod: DateTime.parse(json["per_fecmod"]),
        perUsrcrea: json["per_usrcrea"],
        perUsrmod: json["per_usrmod"],
        marEmpEmpleadoReemplazo: MarEmpEmpleadoReemplazo.fromJson(
            json["mar_emp_empleado_reemplazo"]),
        marMopMotivoPer: MarMopMotivoPer.fromJson(json["mar_mop_motivo_per"]),
      );
}

class MarEmpEmpleadoReemplazo {
  String empCodigo;
  String empCodigoEmp;
  DateTime empFechaNacimiento;
  String empNombres;
  String empApellidos;
  String empEstado;
  DateTime empFeccrea;
  DateTime empFecmod;
  String empUsrcrea;
  String empUsrmod;
  String empCodgen;
  String empCodemp;
  String empCodubi;
  String empCodcon;

  MarEmpEmpleadoReemplazo({
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
  });

  factory MarEmpEmpleadoReemplazo.fromJson(Map<String, dynamic> json) =>
      MarEmpEmpleadoReemplazo(
        empCodigo: json["emp_codigo"],
        empCodigoEmp: json["emp_codigo_emp"],
        empFechaNacimiento: DateTime.parse(json["emp_fecha_nacimiento"]),
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
      );

  Map<String, dynamic> toJson() => {
        "emp_codigo": empCodigo,
        "emp_codigo_emp": empCodigoEmp,
        "emp_fecha_nacimiento": empFechaNacimiento.toIso8601String(),
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
      };
}

class MarMopMotivoPer {
  String mopCodigo;
  String mopNombre;
  String mopEstado;
  DateTime mopFeccrea;
  DateTime mopFecmod;
  String mopUsrcrea;
  String mopUsrmod;

  MarMopMotivoPer({
    required this.mopCodigo,
    required this.mopNombre,
    required this.mopEstado,
    required this.mopFeccrea,
    required this.mopFecmod,
    required this.mopUsrcrea,
    required this.mopUsrmod,
  });

  factory MarMopMotivoPer.fromJson(Map<String, dynamic> json) =>
      MarMopMotivoPer(
        mopCodigo: json["mop_codigo"],
        mopNombre: json["mop_nombre"],
        mopEstado: json["mop_estado"],
        mopFeccrea: DateTime.parse(json["mop_feccrea"]),
        mopFecmod: DateTime.parse(json["mop_fecmod"]),
        mopUsrcrea: json["mop_usrcrea"],
        mopUsrmod: json["mop_usrmod"],
      );
}
