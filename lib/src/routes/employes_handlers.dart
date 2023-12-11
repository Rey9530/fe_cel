import 'package:fluro/fluro.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/modules/auth/viewmodel/provider_auth.dart';
import 'package:marcacion_admin/src/modules/employees/view/add_employes_view.dart';
import 'package:marcacion_admin/src/modules/views.dart';
import 'package:marcacion_admin/src/routes/router.dart';
import 'package:provider/provider.dart';

class EmployesHandlers {
  static Handler list = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.employesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const EmployesView();
    } else {
      return const LoginView();
    }
  });

  static Handler addEmploye = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.employesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const AddEmployeView();
    } else {
      return const LoginView();
    }
  });

  static Handler editEmploye = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.employesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      String? uuid = params['uuid']?.first;
      return AddEmployeView(uuid: uuid);
    } else {
      return const LoginView();
    }
  });
}
