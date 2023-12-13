String convertTimeToAmPm(currentTime) {
  var split = currentTime.split(":");
  if (split.length != 2) return '';
  var hora = '';
  var minutos = '';
  var turno = '';
  if (split.length > 1) {
    hora = split[0];
    turno = "AM";
    if ((int.tryParse(split[0]) ?? 0) > 12) {
      hora = ((int.tryParse(split[0]) ?? 0) - 12).toString();
      turno = "PM";
    }
    if (split[0] == '' || split[0] == '0' || split[0] == '00') {
      hora = '12';
    }
    if (hora.length == 1) {
      hora = "0$hora";
    }
    minutos = split[1];
    if (split[1].length == 1) {
      minutos = "0${split[1]}";
    }
    if (split[1].length == 4) {
      minutos = "${split[1][0]}${split[1][1]}";
      turno = "${split[1][2]}${split[1][3]}";
    }
  }
  return '$hora:$minutos$turno';
}
