import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/employees/viewmodel/employes_provider.dart';
import 'package:provider/provider.dart';

class TablePermissionsWidget extends StatelessWidget {
  const TablePermissionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployeesProvider>(context);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(50.0), // fixed to 100 width
          1: FixedColumnWidth(100.0),
          2: FixedColumnWidth(100.0),
          3: FixedColumnWidth(200.0),
          4: FixedColumnWidth(300.0),
          5: FlexColumnWidth(),
          6: FixedColumnWidth(100.0),
        },
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
                child: _titleText('#'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: _titleText('Fecha inicio'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: _titleText('Fecha fin'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: _titleText('Motivo'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: _titleText('Personal de reemplazo'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: _titleText('Comentario'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: _titleText('Acciones'),
              ),
            ],
          ),
          for (var item in provider.permissions)
            TableRow(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText("#"),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: _contentText(item.perFechaInicio),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText(item.perFechaFin),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText(item.marMopMotivoPer.mopNombre),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText(
                      "${item.marEmpEmpleadoReemplazo.empNombres} ${item.marEmpEmpleadoReemplazo.empApellidos}"),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: _contentText(item.perComentario),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      final dialog = AlertDialog(
                        title: Column(
                          children: [
                            Image.asset("assets/icons/borrarred.png"),
                            Text(
                              'Eliminar permiso de ${item.marMopMotivoPer.mopNombre}',
                              style: const TextStyle(color: error),
                            ),
                          ],
                        ),
                        content: const Text(
                          '¿Confirmas que deseas eliminar este permiso?',
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
                                  await provider
                                      .deleteEmployeePermission(item.perCodigo);
                                  // ignore: use_build_context_synchronously
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
      );

  Text _contentText(title, [isRed = false]) => Text(
        title,
        style: TextStyle(
          color: isRed ? error : primary,
          fontWeight: FontWeight.w300,
        ),
      );
}
