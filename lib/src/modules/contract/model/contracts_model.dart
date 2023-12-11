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
  final String ctrNombre;
  final String ctrNumContrato;
  final int ctrHorasExtras;
  final String ctrFechaInicio;
  final String ctrFechaFin;
  final String ctrFechaInipro;
  final String ctrFechaFinpro;
  final String ctrEstado;
  final DateTime ctrFeccrea;
  final DateTime ctrFecmod;
  final String ctrUsrcrea;
  final String ctrUsrmod;
  final String ctrCodepr;
  final MarEprEmpresas marEprEmpresas;

  Contract({
    required this.ctrCodigo,
    required this.ctrNombre,
    required this.ctrNumContrato,
    required this.ctrHorasExtras,
    required this.ctrFechaInicio,
    required this.ctrFechaFin,
    required this.ctrFechaInipro,
    required this.ctrFechaFinpro,
    required this.ctrEstado,
    required this.ctrFeccrea,
    required this.ctrFecmod,
    required this.ctrUsrcrea,
    required this.ctrUsrmod,
    required this.ctrCodepr,
    required this.marEprEmpresas,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        ctrCodigo: json["ctr_codigo"],
        ctrNombre: json["ctr_nombre"],
        ctrNumContrato: json["ctr_num_contrato"],
        ctrHorasExtras: json["ctr_horas_extras"],
        ctrFechaInicio: json["ctr_fecha_inicio"] != null
            ? DateFormat("dd/MM/y")
                .format(DateTime.parse(json["ctr_fecha_inicio"]))
            : "",
        ctrFechaFin: json["ctr_fecha_fin"] != null
            ? DateFormat("dd/MM/y")
                .format(DateTime.parse(json["ctr_fecha_fin"]))
            : "",
        ctrFechaInipro: json["ctr_fecha_inipro"] != null
            ? DateFormat("dd/MM/y")
                .format(DateTime.parse(json["ctr_fecha_inipro"]))
            : "",
        ctrFechaFinpro: json["ctr_fecha_finpro"] != null
            ? DateFormat("dd/MM/y")
                .format(DateTime.parse(json["ctr_fecha_finpro"]))
            : "",
        ctrEstado: json["ctr_estado"],
        ctrFeccrea: DateTime.parse(json["ctr_feccrea"]),
        ctrFecmod: DateTime.parse(json["ctr_fecmod"]),
        ctrUsrcrea: json["ctr_usrcrea"],
        ctrUsrmod: json["ctr_usrmod"],
        ctrCodepr: json["ctr_codepr"],
        marEprEmpresas: MarEprEmpresas.fromJson(json["mar_epr_empresas"]),
      );

  Map<String, dynamic> toJson() => {
        "ctr_codigo": ctrCodigo,
        "ctr_nombre": ctrNombre,
        "ctr_num_contrato": ctrNumContrato,
        "ctr_horas_extras": ctrHorasExtras,
        "ctr_fecha_inicio": ctrFechaInicio,
        "ctr_fecha_fin": ctrFechaFin,
        "ctr_fecha_inipro": ctrFechaInipro,
        "ctr_fecha_finpro": ctrFechaFinpro,
        "ctr_estado": ctrEstado,
        "ctr_feccrea": ctrFeccrea.toIso8601String(),
        "ctr_fecmod": ctrFecmod.toIso8601String(),
        "ctr_usrcrea": ctrUsrcrea,
        "ctr_usrmod": ctrUsrmod,
        "ctr_codepr": ctrCodepr,
        "mar_epr_empresas": marEprEmpresas.toJson(),
      };
}

class MarEprEmpresas {
  final String eprNombre;
  final String eprCodigo;

  MarEprEmpresas({
    required this.eprNombre,
    required this.eprCodigo,
  });

  factory MarEprEmpresas.fromJson(Map<String, dynamic> json) => MarEprEmpresas(
        eprNombre: json["epr_nombre"] ?? '',
        eprCodigo: json["epr_codigo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "epr_nombre": eprNombre,
        "epr_codigo": eprCodigo,
      };
}
