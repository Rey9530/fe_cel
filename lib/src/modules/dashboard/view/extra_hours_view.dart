import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/contract/viewmodel/contracts_provider.dart';
import 'package:marcacion_admin/src/modules/dashboard/viewmodel/dashboard_provider.dart';
import 'package:provider/provider.dart';

class ExtraHoursView extends StatelessWidget {
  const ExtraHoursView({super.key, this.uuid});
  final String? uuid;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContractsProvider>(context, listen: false);
    provider.uuid = uuid;
    return FutureBuilder(
      future: provider.getRegister(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: primary));
        } else {
          return const BodyExtraHoursWidget();
        }
      },
    );
  }
}

class BodyExtraHoursWidget extends StatelessWidget {
  const BodyExtraHoursWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BreadCrumbsWidget(
              title: 'Dashboard / Horas extras',
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Text(
                "En esta sección podrás autorizar o rechazar las horas extras que hayan sido registradas a partir de la hora de salida de marcación después del horario asignado de cada colaborador.",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  // fontSize: 16,
                  color: textGray,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                _SearchTextfieldWidget(),
                Spacer(),
                // _LoadingWidget(),
                Spacer(),
              ],
            ),
            SizedBox(height: 40),
            TabsCustomWidget(),
            _CustomTableWidget(),
          ],
        ),
      ),
    );
  }
}

class TabsCustomWidget extends StatelessWidget {
  const TabsCustomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provDash = Provider.of<DashboardProvider>(context);
    var provPro = Provider.of<ContractsProvider>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ItemTabWidget(
            title: 'Por Procesar',
            activate: provDash.tabActive == '1',
            onTap: () {
              provDash.changeTabActive('1');
            },
          ),
          const SizedBox(width: 25),
          ItemTabWidget(
            title: 'Validadas',
            activate: provDash.tabActive == '2',
            onTap: () {
              provDash.changeTabActive('2');
            },
          ),
          const SizedBox(width: 25),
          ItemTabWidget(
            title: 'Rechazadas',
            activate: provDash.tabActive == '3',
            onTap: () {
              provDash.changeTabActive('3');
            },
          ),
          const Spacer(),
          const Text(
            "Proyecto: ",
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            provPro.contractName.text,
            style: const TextStyle(
              color: primary,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}

class ItemTabWidget extends StatelessWidget {
  const ItemTabWidget({
    super.key,
    required this.title,
    required this.activate,
    required this.onTap,
  });
  final String title;
  final bool activate;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: activate
                ? const BorderSide(
                    width: 2,
                    color: primaryv2,
                  )
                : BorderSide.none,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: primaryv2,
            fontWeight: activate ? FontWeight.bold : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _SearchTextfieldWidget extends StatefulWidget {
  const _SearchTextfieldWidget();

  @override
  State<_SearchTextfieldWidget> createState() => _SearchTextfieldWidgetState();
}

class _SearchTextfieldWidgetState extends State<_SearchTextfieldWidget> {
  Timer? _debounce;
  bool loading = false;
  _onSearchChanged(String query) {
    setState(() {
      loading = true;
    });
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      // do something with query
      // var provider = Provider.of<ContractsProvider>(context, listen: false);
      // provider.query = query;
      // await provider.getEmployees();
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: loading
              ? Container(
                  padding: const EdgeInsets.only(right: 20),
                  // width: 20,
                  height: 20,
                  child: const CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
          prefixIcon: Icon(
            Icons.search,
            color: getTheme(context).primary,
          ),
          labelText: " Búsqueda de empleado",
          // suffixIcon:
          labelStyle: TextStyle(
            color: getTheme(context).primary,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: getTheme(context).primary,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: getTheme(context).primary,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: getTheme(context).primary,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }
}

class _CustomTableWidget extends StatelessWidget {
  const _CustomTableWidget();

  @override
  Widget build(BuildContext context) {
    var provDash = Provider.of<DashboardProvider>(context, listen: false);
    return FutureBuilder(
      future: provDash.getHoursExtra(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: primary));
        } else {
          return const BodyTableWidget();
        }
      },
    );
  }
}

class BodyTableWidget extends StatelessWidget {
  const BodyTableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provDash = Provider.of<DashboardProvider>(context, listen: false);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10),
      child: Table(
        border: TableBorder.all(color: const Color(0XFFEFEFEF)),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: secondary40,
              borderRadius: BorderRadius.circular(4),
            ),
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: _titleText('Nombres'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: _titleText('Apellidos'),
              ),
              Container(
                width: 50,
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                child: _titleText('Tipo de\ncontratación'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                child: _titleText('Sede\nasignada'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: _titleText('Fecha'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                child: _titleText('Código\nde empleado'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                child: _titleText('Horas a\nvalidar'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: _titleText('Acciones'),
              ),
            ],
          ),
          for (var item in provDash.porProcesar)
            TableRow(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText(item.nombre),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: _contentText(item.apellidos),
                ),
                Container(
                  width: 50,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText(item.tipoContratacion),
                ),
                Container(
                  width: 50,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText(item.sede),
                ),
                Container(
                  width: 50,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText(item.hisFeccrea),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText(item.codigoEmpleado),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText(item.hisTpExtra),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText("Acciones"),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Text _titleText(title) => Text(
        title,
        style: const TextStyle(
          color: primary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      );

  Text _contentText(title, [isRed = false]) => Text(
        title,
        style: TextStyle(
          color: isRed ? error : primary,
          fontWeight: FontWeight.w300,
        ),
      );
}
