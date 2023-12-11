import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/modules/auth/model/models_auth.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/routes/router.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;
  AuthProvider() {
    isAuthenticated();
  }

  User? user;
  login(String userCode, String password) async {
    var data = {
      "user_code": userCode,
      "password": password,
    };

    try {
      final resp = await DioConexion.post_('/users/login', data);
      final authResponse = UserModel.fromJson(resp);
      user = authResponse.data;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', user!.token);
      LocalStorage.prefs.setString('nombres', user!.usrNombres);
      LocalStorage.prefs.setString('apellidos', user!.usrApellidos);
      LocalStorage.prefs.setString('codigo', user!.usrCodigoEmple);
      DioConexion.configureDio();
      NavigationService.replaceTo(Flurorouter.dashboardRoute);

      notifyListeners();
      return true;
    } catch (e) {
      NotificationsService.showSnackbarError('Usuario / Password no válidos');
      return false;
    }
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      NavigationService.replaceTo(Flurorouter.loginRoute);
      return false;
    }

    try {
      final resp = await DioConexion.get_('/users/check-status');
      final authReponse = UserModel.fromJson(resp);
      LocalStorage.prefs.setString('token', authReponse.data.token);
      user = authReponse.data;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      authStatus = AuthStatus.notAuthenticated;
      NavigationService.replaceTo(Flurorouter.loginRoute);
      notifyListeners();
      return false;
    }
  }

  logout() {
    LocalStorage.prefs.remove('token');
    LocalStorage.prefs.remove('nombres');
    LocalStorage.prefs.remove('apellidos');
    LocalStorage.prefs.remove('codigo');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
    NavigationService.replaceTo(Flurorouter.loginRoute);
  }
}
