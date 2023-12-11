// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/modules/contract/model/index.dart';
import 'package:provider/provider.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/contract/viewmodel/contracts_provider.dart';

class EmployesContractsView extends StatelessWidget {
  const EmployesContractsView({super.key, this.uuid});
  final String? uuid;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContractsProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.loadToEmployes(uuid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return const EmployesBodyWidget();
      },
    );
  }
}

class EmployesBodyWidget extends StatelessWidget {
  const EmployesBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContractsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          BreadCrumWidget(
            title:
                'Contratos / ${provider.contract?.ctrNombre ?? ''} / Empleados',
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: GoBackWidget(),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Has una búsqueda de los empleados a añadir a este contrato.",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: const ListHoursWidgets(),
          ),
        ],
      ),
    );
  }
}

class ListHoursWidgets extends StatelessWidget {
  const ListHoursWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SearchTextfieldWidget(),
            SizedBox(height: 10),
            TableEmployesContract(),
          ],
        ),
        ListItemSearchWidget(),
      ],
    );
  }
}

class TableEmployesContract extends StatelessWidget {
  const TableEmployesContract({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContractsProvider>(context);
    var style = TextStyle(
      fontWeight: FontWeight.w600,
      color: getTheme(context).primary,
    );
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: PaginatedDataTable(
          dataRowMinHeight: 60,
          dataRowMaxHeight: 65,
          columns: [
            DataColumn(label: Text('Nombres', style: style)),
            DataColumn(label: Text('Apellidos', style: style)),
            DataColumn(label: Text('Código de empleado', style: style)),
            DataColumn(label: Text('Tipo de contratación', style: style)),
            DataColumn(label: Text('Sede asignada', style: style)),
            DataColumn(label: Text('Horario', style: style)),
            DataColumn(label: Text('Acciones', style: style)),
          ],
          source: EmployesContractsTDS(
              provider.emplContract, context, provider.emplContract.length),
          // onPageChanged: (value) async {
          //   provider.quantity = value;
          //   await provider.getEmployes(true);
          // },
          onRowsPerPageChanged: (value) async {
            // provider.quantity = value ?? 10;
            // await provider.getEmployes(true);
            // setState(() {
            //   _rowsPerPage = value ?? 10;
            // });
          },
          // rowsPerPage: _rowsPerPage,
          headingRowColor: MaterialStateProperty.all(headerRowTable),
        ),
      ),
    );
  }
}

class ListItemSearchWidget extends StatelessWidget {
  const ListItemSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContractsProvider>(context);
    return provider.employes.isNotEmpty
        ? Positioned(
            top: 60,
            child: Container(
              width: 440,
              height: 300,
              decoration: BoxDecoration(
                color: Color(0XFFF3F3F4),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.only(left: 40, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    for (var employe in provider.employes)
                      ItemSeacrhWidget(
                        employe: employe,
                      ),
                  ],
                ),
              ),
            ),
          )
        : SizedBox.shrink();
  }
}

class ItemSeacrhWidget extends StatelessWidget {
  const ItemSeacrhWidget({
    super.key,
    required this.employe,
  });
  final EmployesContract employe;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContractsProvider>(context, listen: false);
    return InkWell(
      onTap: () async {
        await provider.agregarItem(employe.empCodigo);
      },
      child: SizedBox(
        height: 40,
        child: Text(
          "${employe.empNombres} ${employe.empApellidos} (${employe.empCodigoEmp})",
          style: TextStyle(
            color: Color(0XFF1D1D00),
            fontWeight: FontWeight.w400,
            fontSize: 18,
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
      var provider = Provider.of<ContractsProvider>(context, listen: false);
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
