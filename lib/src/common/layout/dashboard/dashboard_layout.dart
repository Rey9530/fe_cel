import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/routes/router.dart';
import 'package:provider/provider.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTheme(context).primary,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            const _SideBarMenuWidget(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideBarMenuWidget extends StatefulWidget {
  const _SideBarMenuWidget();

  @override
  State<_SideBarMenuWidget> createState() => _SideBarMenuWidgetState();
}

class _SideBarMenuWidgetState extends State<_SideBarMenuWidget> {
  String menu = 'dashboard';

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 25,
            left: 0,
            bottom: 100,
          ),
          child: Image.asset(
            "assets/images/icon.png",
          ),
        ),
        ItemsMenuWidget(
          active: sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          title: 'Dashboard',
          iconName: 'dashboard',
          onPress: () =>
              NavigationService.replaceTo(Flurorouter.dashboardRoute),
        ),
        ItemsMenuWidget(
          active: sideMenuProvider.currentPage == Flurorouter.companiesRoute,
          title: 'empresas',
          iconName: 'company',
          onPress: () =>
              NavigationService.replaceTo(Flurorouter.companiesRoute),
        ),
        ItemsMenuWidget(
          active: sideMenuProvider.currentPage == Flurorouter.employesRoute,
          title: 'Empleados',
          iconName: 'employes',
          onPress: () => NavigationService.replaceTo(Flurorouter.employesRoute),
        ),
        ItemsMenuWidget(
          active: sideMenuProvider.currentPage == Flurorouter.contractsRoute,
          title: 'Contratos',
          iconName: 'proyect',
          onPress: () =>
              NavigationService.replaceTo(Flurorouter.contractsRoute),
        ),
        ItemsMenuWidget(
          active: sideMenuProvider.currentPage == Flurorouter.reportsRoute,
          title: 'Reportes',
          iconName: 'report',
          onPress: () => NavigationService.replaceTo(Flurorouter.reportsRoute),
        ),
        ItemsMenuWidget(
          active: sideMenuProvider.currentPage == Flurorouter.userProfileRoute,
          title: 'Usuario',
          iconName: 'users',
          onPress: () =>
              NavigationService.replaceTo(Flurorouter.userProfileRoute),
        ),
        const Spacer(),
        const VersionWidget(),
        const SizedBox(height: 60)
      ],
    );
  }
}

class VersionWidget extends StatelessWidget {
  const VersionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Versión\n1.0\nQ1-2024",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ItemsMenuWidget extends StatelessWidget {
  const ItemsMenuWidget({
    super.key,
    required this.active,
    required this.title,
    required this.iconName,
    required this.onPress,
  });
  final bool active;
  final String title;
  final String iconName;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: active ? null : () => onPress(),
      borderRadius: BorderRadius.circular(16),
      child: active
          ? AnimatedContainer(
              width: 168,
              height: 95,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              duration: const Duration(seconds: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/${iconName}_primary.png"),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: getTheme(context).primary,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              width: 168,
              height: 95,
              decoration: BoxDecoration(
                color: getTheme(context).primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/${iconName}_white.png"),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
