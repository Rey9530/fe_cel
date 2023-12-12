String? validationIsEmail(String value) {
  //Si es valido retornara null, de caso contrario retornara un string
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value))
      ? "Debe ser un correo electrónico válido"
      : null;
}

String? validationIsDate(String value) {
  //Si es valido retornara null, de caso contrario retornara un string
  String pattern =
      r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{4})$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? "Debe ser una fecha válida" : null;
}

String? minLength5(String value) {
  //Si es valido retornara null, de caso contrario retornara un string
  return (value.length < 5) ? "Debe tener almenos 5 caracteres" : null;
}

String? minLength10(String value) {
  //Si es valido retornara null, de caso contrario retornara un string
  return (value.length < 5) ? "Debe tener almenos 10 caracteres" : null;
}
