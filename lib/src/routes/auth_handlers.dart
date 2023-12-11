import 'package:fluro/fluro.dart';
import 'package:marcacion_admin/src/modules/auth/viewmodel/auth_provider.dart';
import 'package:marcacion_admin/src/modules/views.dart';
import 'package:provider/provider.dart';

class AuthHandlers {
  static Handler login = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);

      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const LoginView();
      }
      // else if (authProvider.authStatus != AuthStatus.checking) {
      //   print(authProvider.authStatus);
      //   return FutureBuilder(
      //     future: null,
      //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //       Future.microtask(() {
      //         NavigationService.replaceTo(Flurorouter.dashboardRoute);
      //       });
      //       return const SizedBox.shrink();
      //     },
      //   );
      // }
      else {
        return const DashboardView();
      }
    },
  );
}
