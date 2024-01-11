import 'package:intl/intl.dart';

class MakingCtrResponse {
  final List<MakingItem> data;
  final int status;
  final String message;

  MakingCtrResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  factory MakingCtrResponse.fromJson(Map<String, dynamic> json) =>
      MakingCtrResponse(
        data: List<MakingItem>.from(
          json["data"].map(
            (x) => MakingItem.fromJson(x),
          ),
        ),
        status: json["status"],
        message: json["message"],
      );
}

class MakingItem {
  final String nombres;
  final String apellidos;
  final String codigo;
  final String id;
  final String entrada;
  final String salida;
  final String fecha;
  final String sede;
  final String tiempoExtra;
  final String tiempoTrabajado;
  final bool salidaTemprana;
  final bool entradaTardia;

  MakingItem({
    required this.nombres,
    required this.apellidos,
    required this.codigo,
    required this.id,
    required this.entrada,
    required this.salida,
    required this.fecha,
    required this.sede,
    required this.tiempoExtra,
    required this.tiempoTrabajado,
    required this.salidaTemprana,
    required this.entradaTardia,
  });

  factory MakingItem.fromJson(Map<String, dynamic> json) => MakingItem(
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        sede: json["sede"],
        codigo: json["codigo"],
        id: json["id"],
        entrada: json["entrada"] != null
            ? DateFormat("h:mm a").format(
                DateTime.parse(json["entrada"]).toLocal(),
              )
            : "N/A",
        salida: json["salida"] != null
            ? DateFormat("h:mm a").format(
                DateTime.parse(json["salida"]).toLocal(),
              )
            : "N/A",
        tiempoExtra: json["tiempo_extra"],
        tiempoTrabajado: json["tiempo_trabajado"],
        fecha: json["fecha"] != null
            ? DateFormat("dd/MM/y").format(DateTime.parse(json["fecha"]))
            : "",
        salidaTemprana: json["salida_temprana"] ?? false,
        entradaTardia: json["entrada_tardia"] ?? false,
      );
}
