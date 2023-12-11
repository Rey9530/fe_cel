import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/contract/model/index.dart';
import 'package:marcacion_admin/src/modules/contract/viewmodel/contracts_provider.dart';
import 'package:marcacion_admin/src/routes/router.dart';
import 'package:provider/provider.dart';

class ContractsView extends StatelessWidget {
  const ContractsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const [
          BreadCrumWidget(
            title: 'Contratos',
          ),
          _BodyContract(),
        ],
      ),
    );
  }
}

class _BodyContract extends StatelessWidget {
  const _BodyContract();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          _BtnNewContractsWidget(),
          SizedBox(height: 20),
          _TextParraWidget(),
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
    Provider.of<ContractsProvider>(context, listen: false).getContracts();
  }

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

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
        child: (provider.contracts.isNotEmpty)
            ? PaginatedDataTable(
                columns: [
                  DataColumn(label: Text('Nombre de contrato', style: style)),
                  DataColumn(label: Text('Código de\ncontrato', style: style)),
                  DataColumn(
                    label: Text('Nombre\nde la empresa', style: style),
                  ),
                  DataColumn(label: Text('Inicio de\ncontrato', style: style)),
                  DataColumn(label: Text('Fin de\ncontrato', style: style)),
                  DataColumn(label: Text('Prorrogable', style: style)),
                  DataColumn(label: Text('Acciones', style: style)),
                ],
                source: ContractsTDS(
                  provider.contracts,
                  context,
                  provider.contracts.length,
                ),
                // onPageChanged: (value) async {
                //   provider.quantity = value;
                //   await provider.getEmployes(true);
                // },
                onRowsPerPageChanged: (value) async {
                  // provider.quantity = value ?? 10;
                  // await provider.getEmployes(true);
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

class _BtnNewContractsWidget extends StatelessWidget {
  const _BtnNewContractsWidget();

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
          NavigationService.navigateTo(Flurorouter.contractsCreateRoute);
        },
        child: const Text(
          "Nuevo contrato",
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
          "En esta sección podrás crear los contratos que CEL tendrá con las empresas tercerizadas que has creado en el módulo ",
          style: TextStyle(
            color: textGray,
            fontWeight: FontWeight.w400,
          ),
        ),
        InkWell(
          onTap: () {
            NavigationService.replaceTo(Flurorouter.companiesRoute);
          },
          child: const Text(
            "Empresas",
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
