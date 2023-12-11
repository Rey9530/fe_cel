class UserModel {
  final User data;
  final int status;
  final String message;

  UserModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: User.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class User {
  final String usrCodigoEmple;
  final String usrCodigo;
  final String usrNombres;
  final String usrApellidos;
  final String usrEstado;
  final String token;

  User({
    required this.usrCodigoEmple,
    required this.usrCodigo,
    required this.usrNombres,
    required this.usrApellidos,
    required this.usrEstado,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        usrCodigoEmple: json["usr_codigo_emple"],
        usrCodigo: json["usr_codigo"],
        usrNombres: json["usr_nombres"],
        usrApellidos: json["usr_apellidos"],
        usrEstado: json["usr_estado"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "usr_codigo_emple": usrCodigoEmple,
        "usr_codigo": usrCodigo,
        "usr_nombres": usrNombres,
        "usr_apellidos": usrApellidos,
        "usr_estado": usrEstado,
        "token": token,
      };
}
