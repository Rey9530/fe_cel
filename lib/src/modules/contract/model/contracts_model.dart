import 'package:intl/intl.dart';

class ContractsResponse {
  final List<Contract> data;
  final int status;
  final String message;

  ContractsResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ContractsResponse.fromJson(Map<String, dynamic> json) =>
      ContractsResponse(
        data:
            List<Contract>.from(json["data"].map((x) => Contract.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Contract {
  final String ctrCodigo;
  final String ctrName;
  final String ctrNumContrato;
  final int ctrHorasExtras;
  final String ctrDateStart;
  final String ctrDateEnd;
  final String ctrDateStartPro;
  final String ctrDateEndPro;
  final String ctrStatus;
  final DateTime ctrFecCreate;
  final DateTime ctrFecUpdate;
  final String ctrUsrCreate;
  final String ctrUsrUpdate;
  final String ctrCodePr;
  final MarEprCompanies marEprCompanies;

  Contract({
    required this.ctrCodigo,
    required this.ctrName,
    required this.ctrNumContrato,
    required this.ctrHorasExtras,
    required this.ctrDateStart,
    required this.ctrDateEnd,
    required this.ctrDateStartPro,
    required this.ctrDateEndPro,
    required this.ctrStatus,
    required this.ctrFecCreate,
    required this.ctrFecUpdate,
    required this.ctrUsrCreate,
    required this.ctrUsrUpdate,
    required this.ctrCodePr,
    required this.marEprCompanies,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        ctrCodigo: json["ctr_codigo"],
        ctrName: json["ctr_nombre"],
        ctrNumContrato: json["ctr_num_contrato"],
        ctrHorasExtras: json["ctr_horas_extras"],
        ctrDateStart: json["ctr_fecha_inicio"] != null
            ? DateFormat("dd/MM/y")
                .format(DateTime.parse(json["ctr_fecha_inicio"]))
            : "",
        ctrDateEnd: json["ctr_fecha_fin"] != null
            ? DateFormat("dd/MM/y")
                .format(DateTime.parse(json["ctr_fecha_fin"]))
            : "",
        ctrDateStartPro: json["ctr_fecha_inipro"] != null
            ? DateFormat("dd/MM/y")
                .format(DateTime.parse(json["ctr_fecha_inipro"]))
            : "",
        ctrDateEndPro: json["ctr_fecha_finpro"] != null
            ? DateFormat("dd/MM/y")
                .format(DateTime.parse(json["ctr_fecha_finpro"]))
            : "",
        ctrStatus: json["ctr_estado"],
        ctrFecCreate: DateTime.parse(json["ctr_feccrea"]),
        ctrFecUpdate: DateTime.parse(json["ctr_fecmod"]),
        ctrUsrCreate: json["ctr_usrcrea"],
        ctrUsrUpdate: json["ctr_usrmod"],
        ctrCodePr: json["ctr_codepr"],
        marEprCompanies: MarEprCompanies.fromJson(json["mar_epr_empresas"]),
      );

  Map<String, dynamic> toJson() => {
        "ctr_codigo": ctrCodigo,
        "ctr_nombre": ctrName,
        "ctr_num_contrato": ctrNumContrato,
        "ctr_horas_extras": ctrHorasExtras,
        "ctr_fecha_inicio": ctrDateStart,
        "ctr_fecha_fin": ctrDateEnd,
        "ctr_fecha_inipro": ctrDateStartPro,
        "ctr_fecha_finpro": ctrDateEndPro,
        "ctr_estado": ctrStatus,
        "ctr_feccrea": ctrFecCreate.toIso8601String(),
        "ctr_fecmod": ctrFecUpdate.toIso8601String(),
        "ctr_usrcrea": ctrUsrCreate,
        "ctr_usrmod": ctrUsrUpdate,
        "ctr_codepr": ctrCodePr,
        "mar_epr_empresas": marEprCompanies.toJson(),
      };
}

class MarEprCompanies {
  final String eprName;
  final String eprCodigo;

  MarEprCompanies({
    required this.eprName,
    required this.eprCodigo,
  });

  factory MarEprCompanies.fromJson(Map<String, dynamic> json) =>
      MarEprCompanies(
        eprName: json["epr_nombre"] ?? '',
        eprCodigo: json["epr_codigo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "epr_nombre": eprName,
        "epr_codigo": eprCodigo,
      };
}
