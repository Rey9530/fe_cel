import 'package:fluro/fluro.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/modules/auth/viewmodel/provider_auth.dart';
import 'package:marcacion_admin/src/modules/views.dart';
import 'package:marcacion_admin/src/routes/router.dart';
import 'package:provider/provider.dart';

class CompaniesHandlers {
  static Handler list = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.companiesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CompaniesView();
    } else {
      return const LoginView();
    }
  });
}
