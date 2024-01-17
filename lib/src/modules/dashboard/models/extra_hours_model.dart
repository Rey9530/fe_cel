import 'package:intl/intl.dart';

class RespExtraHours {
  DataHoursExtra data;
  int status;
  String message;

  RespExtraHours({
    required this.data,
    required this.status,
    required this.message,
  });

  factory RespExtraHours.fromJson(Map<String, dynamic> json) => RespExtraHours(
        data: DataHoursExtra.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );
}

class DataHoursExtra {
  List<PorProcesar> porProcesar;
  List<PorProcesar> validadas;
  List<PorProcesar> rechazadas;

  DataHoursExtra({
    required this.porProcesar,
    required this.validadas,
    required this.rechazadas,
  });

  factory DataHoursExtra.fromJson(Map<String, dynamic> json) => DataHoursExtra(
        porProcesar: List<PorProcesar>.from(
            json["porProcesar"].map((x) => PorProcesar.fromJson(x))),
        validadas: List<PorProcesar>.from(
            json["validadas"].map((x) => PorProcesar.fromJson(x))),
        rechazadas: List<PorProcesar>.from(
            json["rechazadas"].map((x) => PorProcesar.fromJson(x))),
      );
}

class PorProcesar {
  String hisCodigo;
  String hisHoraEntrada;
  bool hisEntradaTarde;
  String hisHoraSalida;
  bool hisSalidaTemp;
  String hisTpTrabajado;
  String hisTpExtra;
  String hisTpExtraApro;
  String hisFeccreacion;
  String empEstado;
  String hisFeccrea;
  String hisFecmod;
  String hisUsrcrea;
  String hisUsrmod;
  String hisCodasi;
  String nombre;
  String apellidos;
  String tipoContratacion;
  String sede;
  String codigoEmpleado;

  PorProcesar({
    required this.hisCodigo,
    required this.hisHoraEntrada,
    required this.hisEntradaTarde,
    required this.hisHoraSalida,
    required this.hisSalidaTemp,
    required this.hisTpTrabajado,
    required this.hisTpExtra,
    required this.hisTpExtraApro,
    required this.hisFeccreacion,
    required this.empEstado,
    required this.hisFeccrea,
    required this.hisFecmod,
    required this.hisUsrcrea,
    required this.hisUsrmod,
    required this.hisCodasi,
    required this.nombre,
    required this.apellidos,
    required this.tipoContratacion,
    required this.sede,
    required this.codigoEmpleado,
  });

  factory PorProcesar.fromJson(Map<String, dynamic> json) => PorProcesar(
        hisCodigo: json["his_codigo"],
        hisHoraEntrada: json["his_hora_entrada"],
        hisEntradaTarde: json["his_entrada_tarde"],
        hisHoraSalida: json["his_hora_salida"],
        hisSalidaTemp: json["his_salida_temp"],
        hisTpTrabajado: json["his_tp_trabajado"],
        hisTpExtra: json["his_tp_extra"],
        hisTpExtraApro: json["his_tp_extra_apro"],
        hisFeccreacion: json["his_feccreacion"],
        empEstado: json["emp_estado"],
        hisFeccrea: json["his_feccrea"] != null
            ? DateFormat("dd/MM/y").format(DateTime.parse(json["his_feccrea"]))
            : "",
        hisFecmod: json["his_fecmod"],
        hisUsrcrea: json["his_usrcrea"],
        hisUsrmod: json["his_usrmod"],
        hisCodasi: json["his_codasi"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        tipoContratacion: json["tipo_contratacion"],
        sede: json["sede"],
        codigoEmpleado: json["codigo_empleado"],
      );
}
