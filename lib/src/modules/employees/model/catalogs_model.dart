// ignore_for_file: library_private_types_in_public_api

import 'package:marcacion_admin/src/modules/employees/model/contratation_model.dart';
import 'package:marcacion_admin/src/modules/employees/model/gender_model.dart';
import 'package:marcacion_admin/src/modules/employees/model/sedes_model.dart';

class CatalogResponse {
  final CatalogData data;
  final int status;
  final String message;

  CatalogResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory CatalogResponse.fromJson(Map<String, dynamic> json) =>
      CatalogResponse(
        data: CatalogData.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class CatalogData {
  final List<Sede> sedes;
  final List<Contratation> contratation;
  final List<Gender> gender;
  final List<Company> companies;

  CatalogData({
    required this.sedes,
    required this.contratation,
    required this.gender,
    required this.companies,
  });

  factory CatalogData.fromJson(Map<String, dynamic> json) => CatalogData(
        sedes: List<Sede>.from(json["sedes"].map((x) => Sede.fromJson(x))),
        contratation: List<Contratation>.from(
            json["contratation"].map((x) => Contratation.fromJson(x))),
        gender:
            List<Gender>.from(json["gender"].map((x) => Gender.fromJson(x))),
        companies: List<Company>.from(
            json["companies"].map((x) => Company.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sedes": List<dynamic>.from(sedes.map((x) => x.toJson())),
        "contratation": List<dynamic>.from(contratation.map((x) => x.toJson())),
        "gender": List<dynamic>.from(gender.map((x) => x.toJson())),
        "companies": List<dynamic>.from(companies.map((x) => x.toJson())),
      };
}

class Company {
  final String eprCodigo;
  final String eprNombre;

  Company({
    required this.eprCodigo,
    required this.eprNombre,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        eprCodigo: json["epr_codigo"],
        eprNombre: json["epr_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "epr_codigo": eprCodigo,
        "epr_nombre": eprNombre,
      };
}
