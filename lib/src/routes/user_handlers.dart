import 'package:fluro/fluro.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/modules/auth/viewmodel/provider_auth.dart';
import 'package:marcacion_admin/src/modules/user/view/user_view.dart';
import 'package:marcacion_admin/src/modules/views.dart';
import 'package:marcacion_admin/src/routes/router.dart';
import 'package:provider/provider.dart';

class UserHandlers {
  static Handler view = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.userProfileRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const UserView();
    } else {
      return const LoginView();
    }
  });
}
