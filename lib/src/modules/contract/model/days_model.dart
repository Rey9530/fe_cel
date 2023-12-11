import 'package:flutter/material.dart';

class DaysResponse {
  final List<Day> data;
  final int status;
  final String message;

  DaysResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory DaysResponse.fromJson(Map<String, dynamic> json) => DaysResponse(
        data: List<Day>.from(json["data"].map((x) => Day.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class RequestSchedule {
  final List<Schedule> list;

  RequestSchedule({required this.list});

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class Schedule {
  final Day day;
  final TextEditingController entrada1;
  final TextEditingController salida1;
  final TextEditingController entrada2;
  final TextEditingController salida2;

  Schedule({
    required this.day,
    required this.entrada1,
    required this.salida1,
    required this.entrada2,
    required this.salida2,
  });

  Map<String, dynamic> toJson() => {
        "day": day.toJson(),
        "entrada1": entrada1.text,
        "salida1": salida1.text,
        "entrada2": entrada2.text,
        "salida2": salida2.text,
      };
}

class Day {
  final String diaCodigo;
  final String diaNombre;
  final String diaDiaCodigo;

  Day({
    required this.diaCodigo,
    required this.diaNombre,
    required this.diaDiaCodigo,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        diaCodigo: json["dia_codigo"],
        diaNombre: json["dia_nombre"],
        diaDiaCodigo: json["dia_dia_codigo"],
      );

  Map<String, dynamic> toJson() => {
        "dia_codigo": diaCodigo,
        "dia_nombre": diaNombre,
        "dia_dia_codigo": diaDiaCodigo,
      };
}
