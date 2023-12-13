// ignore_for_file: library_private_types_in_public_api

import 'package:marcacion_admin/src/modules/employees/model/models.dart';

class EmployeeResponse {
  final Employee data;
  final int status;
  final String message;

  EmployeeResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeResponse(
        data: Employee.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}
