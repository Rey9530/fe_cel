import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/modules/auth/model/models_auth.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  var password = TextEditingController();
  var passwordNew = TextEditingController();
  var passwordRepeat = TextEditingController();

  bool isReady = false;
  bool loading = false;

  bool condictionCharacter = false;
  bool condictionCapital = false;
  bool condictionNumber = false;
  bool condictionCharSpecial = false;

  updateTextPassword() {
    var textPassword = passwordNew.text;

    condictionCharacter = textPassword.length >= 8;
    condictionCapital = RegExp(r'[A-Z]').hasMatch(textPassword);
    condictionNumber = RegExp(r'[0-9]').hasMatch(textPassword);
    condictionCharSpecial =
        RegExp(r'[!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]').hasMatch(textPassword);
    if (condictionCharacter &&
        condictionCapital &&
        condictionNumber &&
        condictionCharSpecial &&
        passwordNew.text == passwordRepeat.text) {
      isReady = true;
    } else {
      isReady = false;
    }
    notifyListeners();
  }

  updatePassword() async {
    var data = {
      "curren_password": password.text,
      "new_password": passwordNew.text,
    };

    try {
      loading = true;
      notifyListeners();
      final resp = await DioConexion.post_('/users/update/password', data);

      notifyListeners();
      if (resp['status'] != null) {
        password = TextEditingController();
        passwordNew = TextEditingController();
        passwordRepeat = TextEditingController();
        NotificationsService.showSnackbarSuccess('Contraseña actualizada');
        NavigationService.goBack();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // NotificationsService.showSnackbarError('Usuario / Password no válidos');
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
