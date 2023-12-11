import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/models/dropdown_buttom_data_model.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/employees/model/employes_dts.dart';
import 'package:marcacion_admin/src/modules/employees/model/models.dart';
import 'package:marcacion_admin/src/modules/employees/viewmodel/employes_provider.dart';
import 'package:marcacion_admin/src/routes/router.dart';
import 'package:provider/provider.dart';

class EmployesView extends StatelessWidget {
  const EmployesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const [
          BreadCrumWidget(
            title: 'Empleados',
          ),
          _BodyEmployes(),
        ],
      ),
    );
  }
}

class _BodyEmployes extends StatelessWidget {
  const _BodyEmployes();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          _BtnNewEmployedWidget(),
          SizedBox(height: 20),
          _TextParraWidget(),
          SizedBox(height: 20),
          _FilterEmployesWidget(),
          SizedBox(height: 20),
          _ListEmployestWidget()
        ],
      ),
    );
  }
}

class _ListEmployestWidget extends StatefulWidget {
  const _ListEmployestWidget();

  @override
  State<_ListEmployestWidget> createState() => _ListEmployestWidgetState();
}

class _ListEmployestWidgetState extends State<_ListEmployestWidget> {
  @override
  void initState() {
    super.initState();

    Provider.of<EmployesProvider>(context, listen: false).employes = [];
    Provider.of<EmployesProvider>(context, listen: false).getEmployes();
  }

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployesProvider>(context);
    var style = TextStyle(
      fontWeight: FontWeight.w600,
      color: getTheme(context).primary,
    );
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: (provider.employes.isNotEmpty)
            ? PaginatedDataTable(
                columns: [
                  DataColumn(label: Text('Código\nde empleado', style: style)),
                  DataColumn(label: Text('Nombres', style: style)),
                  DataColumn(label: Text('Apellidos', style: style)),
                  DataColumn(label: Text('Fecha de\nnacimiento', style: style)),
                  DataColumn(label: Text('Género', style: style)),
                  DataColumn(
                      label: Text('Tipo de\ncontratación', style: style)),
                  DataColumn(label: Text('Sede\nasignada', style: style)),
                  DataColumn(label: Text('Acciones', style: style)),
                ],
                source: EmployesTDS(
                  provider.employes,
                  context,
                  provider.total,
                ),
                onPageChanged: (value) async {
                  provider.quantity = value;
                  await provider.getEmployes(true);
                },
                onRowsPerPageChanged: (value) async {
                  provider.quantity = value ?? 10;
                  await provider.getEmployes(true);
                  setState(() {
                    _rowsPerPage = value ?? 10;
                  });
                },
                rowsPerPage: _rowsPerPage,
                headingRowColor: MaterialStateProperty.all(headerRowTable),
              )
            : const NotDataWidget(),
      ),
    );
  }
}

class _FilterEmployesWidget extends StatelessWidget {
  const _FilterEmployesWidget();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            _SearchTextfieldWidget(),
            Spacer(),
            _LoadingWidget(),
            Spacer(),
            ListComaniesWidget(),
          ],
        ),
      ],
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
      var provider = Provider.of<EmployesProvider>(context, listen: false);
      provider.query = query;
      await provider.getEmployes();
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
    // var provider = Provider.of<EmployesProvider>(context, listen: false);
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

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployesProvider>(context);
    return (provider.loading)
        ? const CircularProgressIndicator()
        : const SizedBox.shrink();
  }
}

class ListComaniesWidget extends StatelessWidget {
  const ListComaniesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployesProvider>(context, listen: false);
    return SizedBox(
      width: 500,
      child: FutureBuilder(
        future: provider.getCompanies(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Companie>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return SelectCompaniesWidget(
            controller: TextEditingController(),
            title: 'Lista de empleados por empresa',
            onChange: (val) {
              provider.company = val.id;
              provider.getEmployes();
            },
            textSelected: 'Mostrar todos',
            items: [
              if (snapshot.data != null)
                ...snapshot.data!.map(
                  (e) => DropdownButtonData(
                    id: e.eprCodigo,
                    title: e.eprNombre,
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}

class _BtnNewEmployedWidget extends StatelessWidget {
  const _BtnNewEmployedWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 195,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(100),
      ),
      child: InkWell(
        onTap: () {
          NavigationService.navigateTo(Flurorouter.employeAddRoute);
        },
        child: const Text(
          "Nuevo empleado",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}

class _TextParraWidget extends StatelessWidget {
  const _TextParraWidget();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      children: [
        const Text(
          "En esta sección podrás crear los empleados que estarán asignados por cada uno de los contratos que hayas creado en el módulo de ",
          style: TextStyle(
            color: textGray,
            fontWeight: FontWeight.w400,
          ),
        ),
        InkWell(
          onTap: () {
            NavigationService.replaceTo(Flurorouter.contractsRoute);
          },
          child: const Text(
            "Contratos",
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
