// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/services/navigation_service.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/employees/model/employes_model.dart';
import 'package:marcacion_admin/src/modules/employees/viewmodel/employes_provider.dart';
import 'package:provider/provider.dart';

class EmployesTDS extends DataTableSource {
  final List<Employe> companies;
  final BuildContext context;
  final int total;

  EmployesTDS(this.companies, this.context, this.total);

  @override
  DataRow? getRow(int index) {
    final employe = companies[index];
    return DataRow.byIndex(
      color:
          MaterialStateColor.resolveWith((states) => const Color(0XFFFFFFFF)),
      index: index,
      cells: [
        DataCell(Text(employe.empCodigoEmp)),
        DataCell(Text(employe.empNombres)),
        DataCell(Text(employe.empApellidos)),
        DataCell(Text(employe.empFechaNacimiento)),
        DataCell(Text(employe.marGenGeneros.genNombre)),
        DataCell(Text(employe.marConContrataciones.conNombre)),
        DataCell(Text(employe.marUbiUbicaciones.ubiNombre)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  NavigationService.navigateTo(
                      "/employes/update/${employe.empCodigo}");
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
                          'Eliminar ${employe.empNombres}',
                          style: const TextStyle(color: error),
                        ),
                      ],
                    ),
                    content: const Text(
                      '¿Confirmas que deseas eliminar a este empleado?',
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
                            onPress: () async {
                              await Provider.of<EmployesProvider>(context,
                                      listen: false)
                                  .deleteEmployes(employe.empCodigo);

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
  int get rowCount => total;

  @override
  int get selectedRowCount => 0;
}
