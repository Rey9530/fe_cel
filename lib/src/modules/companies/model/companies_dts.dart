import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/companies/model/companies_model.dart';
import 'package:marcacion_admin/src/modules/companies/viewmodel/companies_provider.dart';
import 'package:provider/provider.dart';

class CompanieTDS extends DataTableSource {
  final List<Companie> companies;
  final BuildContext context;

  CompanieTDS(this.companies, this.context);

  @override
  DataRow? getRow(int index) {
    final companie = companies[index];
    return DataRow.byIndex(
      color:
          MaterialStateColor.resolveWith((states) => const Color(0XFFFFFFFF)),
      index: index,
      cells: [
        DataCell(Text(companie.eprNombre)),
        DataCell(Text(companie.eprDireccion)),
        DataCell(Text(companie.eprContactoNombre)),
        DataCell(Text(companie.eprContactoCorreo)),
        DataCell(Text(companie.eprContactoTelefono)),
        // Text(companie.marcaEmprePk)
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Provider.of<CompaniesProvider>(context, listen: false)
                      .edit(companie);
                },
                icon: Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.asset("assets/icons/editarsvg.png"),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  final dialog = AlertDialog(
                    title: Column(
                      children: [
                        Image.asset("assets/icons/borrarred.png"),
                        Text(
                          'Eliminar ${companie.eprNombre}',
                          style: const TextStyle(color: error),
                        ),
                      ],
                    ),
                    content: const Text(
                      '¿Confirmas que deseas eliminar esta empresa?',
                      style: TextStyle(color: primary),
                    ),
                    actions: [
                      Row(
                        children: [
                          BtnOutlineWidget(
                            title: 'Cancelar',
                            onPress: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Spacer(),
                          BtnWidget(
                            title: "Si, Eliminar",
                            width: 200,
                            onPress: () {
                              Provider.of<CompaniesProvider>(context,
                                      listen: false)
                                  .deleteEmployes(companie.eprCodigo);

                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  );

                  showDialog(context: context, builder: (_) => dialog);
                },
                icon: Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    color: error,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.asset("assets/icons/delete.png"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => companies.length;

  @override
  int get selectedRowCount => 0;
}
