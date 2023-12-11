// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/layout/dashboard/dashboard_layout.dart';
import 'package:marcacion_admin/src/common/layout/splash/splash_layout.dart';
import 'package:marcacion_admin/src/common/services/services.dart';

import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/auth/viewmodel/auth_provider.dart';
import 'package:marcacion_admin/src/routes/router.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocalStorage.configurePrefs();
  Flurorouter.configureRoutes();
  DioConexion.configureDio();
  runApp(
    const AppProvider(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: setTheme(),
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'SV'), // English, UK
      ],
      builder: (_, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) {
                final authProvider = Provider.of<AuthProvider>(context);

                if (authProvider.authStatus == AuthStatus.checking) {
                  return const SplashLayout();
                }
                if (authProvider.authStatus == AuthStatus.authenticated) {
                  return DashboardLayout(child: child!);
                } else {
                  return child!; //Login
                }
              },
            ),
          ],
        );
      },
    );
  }
}
