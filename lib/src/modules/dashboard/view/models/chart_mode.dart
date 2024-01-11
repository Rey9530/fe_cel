class ChartResponse {
  final DataRespon data;
  final int status;
  final String message;

  ChartResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ChartResponse.fromJson(Map<String, dynamic> json) => ChartResponse(
        data: DataRespon.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );
}

class DataRespon {
  final List<ContrationChart> genders;
  final List<ContrationChart> contrations;
  final ExtraHours extraHours;
  final TimeChart time;
  DataRespon({
    required this.genders,
    required this.contrations,
    required this.extraHours,
    required this.time,
  });

  factory DataRespon.fromJson(Map<String, dynamic> json) => DataRespon(
        genders: List<ContrationChart>.from(
            json["genders"].map((x) => ContrationChart.fromJson(x))),
        contrations: List<ContrationChart>.from(
            json["contrations"].map((x) => ContrationChart.fromJson(x))),
        extraHours: ExtraHours.fromJson(json["extraHours"]),
        time: TimeChart.fromJson(json["time"]),
      );
}

class ContrationChart {
  final String nombre;
  final double cantidad;

  ContrationChart({
    required this.nombre,
    required this.cantidad,
  });

  factory ContrationChart.fromJson(Map<String, dynamic> json) =>
      ContrationChart(
        nombre: json["nombre"].toString(),
        cantidad: double.tryParse(json["cantidad"].toString()) ?? 0.00,
      );
}

class ExtraHours {
  int extraHours;
  int extraHoursC;

  ExtraHours({
    required this.extraHours,
    required this.extraHoursC,
  });

  factory ExtraHours.fromJson(Map<String, dynamic> json) => ExtraHours(
        extraHours: json["extraHours"],
        extraHoursC: json["extraHoursC"],
      );
}

class TimeChart {
  int inLate;
  int onTime;
  int total;

  TimeChart({
    required this.inLate,
    required this.onTime,
    required this.total,
  });

  factory TimeChart.fromJson(Map<String, dynamic> json) => TimeChart(
        inLate: json["inLate"],
        onTime: json["onTime"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "inLate": inLate,
        "onTime": onTime,
        "total": total,
      };
}
