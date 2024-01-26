class RespMotivos {
  List<Motivo> data;
  int status;
  String message;

  RespMotivos({
    required this.data,
    required this.status,
    required this.message,
  });

  factory RespMotivos.fromJson(Map<String, dynamic> json) => RespMotivos(
        data: List<Motivo>.from(json["data"].map((x) => Motivo.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );
}

class Motivo {
  String mopCodigo;
  String mopNombre;
  String mopEstado;
  DateTime mopFeccrea;
  DateTime mopFecmod;
  String mopUsrcrea;
  String mopUsrmod;

  Motivo({
    required this.mopCodigo,
    required this.mopNombre,
    required this.mopEstado,
    required this.mopFeccrea,
    required this.mopFecmod,
    required this.mopUsrcrea,
    required this.mopUsrmod,
  });

  factory Motivo.fromJson(Map<String, dynamic> json) => Motivo(
        mopCodigo: json["mop_codigo"],
        mopNombre: json["mop_nombre"],
        mopEstado: json["mop_estado"],
        mopFeccrea: DateTime.parse(json["mop_feccrea"]),
        mopFecmod: DateTime.parse(json["mop_fecmod"]),
        mopUsrcrea: json["mop_usrcrea"],
        mopUsrmod: json["mop_usrmod"],
      );
}
