class ListHoursCtrResponse {
  final List<ListHoursCtr> data;
  final int status;
  final String message;

  ListHoursCtrResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ListHoursCtrResponse.fromJson(Map<String, dynamic> json) =>
      ListHoursCtrResponse(
        data: List<ListHoursCtr>.from(
            json["data"].map((x) => ListHoursCtr.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class ListHoursCtr {
  final String horCodigo;
  final String horNombre;
  final List<MarHdeDetalleHo> marHdeDetalleHo;

  ListHoursCtr({
    required this.horCodigo,
    required this.horNombre,
    required this.marHdeDetalleHo,
  });

  factory ListHoursCtr.fromJson(Map<String, dynamic> json) => ListHoursCtr(
        horCodigo: json["hor_codigo"],
        horNombre: json["hor_nombre"],
        marHdeDetalleHo: List<MarHdeDetalleHo>.from(
            json["mar_hde_detalle_ho"].map((x) => MarHdeDetalleHo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hor_codigo": horCodigo,
        "hor_nombre": horNombre,
        "mar_hde_detalle_ho":
            List<dynamic>.from(marHdeDetalleHo.map((x) => x.toJson())),
      };
}

class MarHdeDetalleHo {
  String hdeCodigo;
  String hdeCodhor;
  String horCoddia;
  String hdeInicio1;
  String hdeFin1;
  String hdeInicio2;
  String hdeFin2;
  final MarDiaDias marDiaDias;

  MarHdeDetalleHo({
    required this.hdeCodigo,
    required this.hdeCodhor,
    required this.horCoddia,
    required this.hdeInicio1,
    required this.hdeFin1,
    required this.hdeInicio2,
    required this.hdeFin2,
    required this.marDiaDias,
  });

  factory MarHdeDetalleHo.fromJson(Map<String, dynamic> json) =>
      MarHdeDetalleHo(
        hdeCodigo: json["hde_codigo"],
        hdeCodhor: json["hde_codhor"],
        horCoddia: json["hor_coddia"],
        hdeInicio1: json["hde_inicio_1"],
        hdeFin1: json["hde_fin_1"],
        hdeInicio2: json["hde_inicio_2"],
        hdeFin2: json["hde_fin_2"],
        marDiaDias: MarDiaDias.fromJson(json["mar_dia_dias"]),
      );

  Map<String, dynamic> toJson() => {
        "hde_codigo": hdeCodigo,
        "hde_codhor": hdeCodhor,
        "hor_coddia": horCoddia,
        "hde_inicio_1": hdeInicio1,
        "hde_fin_1": hdeFin1,
        "hde_inicio_2": hdeInicio2,
        "hde_fin_2": hdeFin2,
        "mar_dia_dias": marDiaDias.toJson(),
      };
}

class MarDiaDias {
  final String diaCodigo;
  final String diaNombre;
  final String diaDiaCodigo;

  MarDiaDias({
    required this.diaCodigo,
    required this.diaNombre,
    required this.diaDiaCodigo,
  });

  factory MarDiaDias.fromJson(Map<String, dynamic> json) => MarDiaDias(
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
