import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/models/dropdown_button_data_model.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/contract/model/index.dart';
import 'package:marcacion_admin/src/modules/employees/view/widgets/table_body_permissions_widget.dart';
import 'package:marcacion_admin/src/modules/employees/viewmodel/employes_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class PermissionsEmployeeView extends StatelessWidget {
  const PermissionsEmployeeView({super.key, this.uuid});
  final String? uuid;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployeesProvider>(context, listen: false);
    provider.uuid = uuid;
    return FutureBuilder(
      future: provider.getEmployeePermissions(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return const PermissionBodyWidget();
      },
    );
  }
}

class PermissionBodyWidget extends StatelessWidget {
  const PermissionBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const [
          BreadCrumbsWidget(
            title: 'Empleados /  Permisos',
          ),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: GoBackWidget(),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Completa los campos. Al terminar da clic en el botón “Guardar”.",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          _FormewEmployeWidget(),
          TablePermissionsWidget()
        ],
      ),
    );
  }
}

class _FormewEmployeWidget extends StatelessWidget {
  const _FormewEmployeWidget();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployeesProvider>(context);
    return Form(
      key: provider.formKeyPermission,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    Container(
                      padding: const EdgeInsets.only(top: 7),
                      child: const Icon(
                        Icons.info_outline,
                        size: 36,
                      ),
                    ),
                    Text(
                      "Código: ",
                      style: TextStyle(
                        color: getTheme(context).primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                    Text(
                      "TER-${provider.employeeCode}",
                      style: const TextStyle(
                        color: textGraySubtitle,
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400,
                ),
                child: TextFormFieldCustomWidget(
                  isDark: true,
                  enable: false,
                  label: "Nombres",
                  hinText: 'Escribe los nombres del nuevo empleado',
                  controller: provider.employeeName,
                  onChange: (valor) {
                    // provider.validarInput();
                  },
                  validations: const [
                    minLength5,
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400,
                ),
                child: TextFormFieldCustomWidget(
                  isDark: true,
                  enable: false,
                  label: "Apellidos",
                  hinText: 'Escribe los apellidos del nuevo empleado',
                  controller: provider.employeeSurname,
                  onChange: (valor) {
                    // provider.validarInput();
                  },
                  validations: const [
                    minLength5,
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400,
                ),
                child: SelectCompaniesWidget(
                  controller: provider.employeeCompany,
                  title: 'Empresa',
                  isDisable: true,
                  onChange: (val) async {
                    await provider.getContracts(val.id);
                  },
                  selected: DropdownButtonData(
                    id: provider.employeeCompany.text,
                    title: provider.employeeCompany.text,
                  ),
                  items: [
                    ...provider.companies.map(
                      (e) => DropdownButtonData(
                        id: e.eprCodigo,
                        title: e.eprNombre,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400,
                ),
                child: const _SelectContractsWidget(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                constraints: const BoxConstraints(
                  minWidth: 400,
                  maxWidth: 820,
                ),
                child: const SearchEmployes(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400,
                ),
                child: TextFormFieldCustomWidget(
                  isDark: true,
                  label: "Fecha de inicio",
                  hinText: 'dd/mm/AAAA',
                  validations: const [
                    validationIsDate,
                  ],
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '##/##/####',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy,
                    ),
                  ],
                  controller: provider.permissionDateStart,
                  onChange: (valor) async {},
                  suffixIcon: InkWell(
                    onTap: () async {
                      var data = await showDatePicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year, 12, 31),
                        // barrierDismissible: false,
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        locale: const Locale('es', 'ES'),
                      );
                      if (data != null) {
                        String onlydate = DateFormat("dd/MM/yyyy").format(data);
                        provider.permissionDateStart.text = onlydate;
                      }
                    },
                    child: Image.asset("assets/icons/calendar_primary.png"),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400,
                ),
                child: TextFormFieldCustomWidget(
                  isDark: true,
                  label: "Fecha de fin",
                  hinText: 'dd/mm/AAAA',
                  validations: const [
                    validationIsDate,
                  ],
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '##/##/####',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy,
                    ),
                  ],
                  controller: provider.permissionDateEnd,
                  onChange: (valor) async {},
                  suffixIcon: InkWell(
                    onTap: () async {
                      var data = await showDatePicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year, 12, 31),
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        locale: const Locale('es', 'ES'),
                      );
                      if (data != null) {
                        String onlydate = DateFormat("dd/MM/yyyy").format(data);
                        provider.permissionDateEnd.text = onlydate;
                      }
                    },
                    child: Image.asset("assets/icons/calendar_primary.png"),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                constraints: const BoxConstraints(
                  minWidth: 400,
                  maxWidth: 820,
                ),
                child: TextFormFieldCustomWidget(
                  isDark: true,
                  label: "Comentarios",
                  hinText: 'Campo opcional',
                  controller: provider.comment,
                  onChange: (valor) {
                    // provider.validarInput();
                  },
                  validations: const [
                    minLength5,
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400,
                ),
                child: SelectCompaniesWidget(
                  controller: provider.motivoController,
                  title: 'Motivo',
                  // onChange: (val) async {
                  //   await provider.getContracts(val.id);
                  // },
                  // selected: DropdownButtonData(
                  //   id: provider.employeeCompany.text,
                  //   title: provider.employeeCompany.text,
                  // ),
                  items: [
                    ...provider.listmotivos.map(
                      (e) => DropdownButtonData(
                        id: e.mopCodigo,
                        title: e.mopNombre,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                padding: const EdgeInsets.only(right: 100),
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: BtnWidget(
                    width: 200,
                    height: 60,
                    loading: provider.loading,
                    title: "Guardar",
                    onPress: () async {
                      // provider.saveEmploye();
                      if ((provider.formKeyPermission.currentState
                                  ?.validate() ??
                              false) &&
                          provider.employeeReplace.text.isNotEmpty) {
                        await provider.generatePermision();
                      }
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SearchEmployes extends StatefulWidget {
  const SearchEmployes({
    super.key,
  });

  @override
  State<SearchEmployes> createState() => _SearchEmployesState();
}

class _SearchEmployesState extends State<SearchEmployes> {
  List<EmployeesContract> employees = [];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployeesProvider>(context, listen: false);
    return SearchDropdowWidget(
      controller: TextEditingController(),
      title: 'Persona de reemplazo',
      onFind: (p0) async {
        employees = await provider.getEmployees(p0);
        setState(() {});
      },
      onChange: (p0) => provider.employeeReplace.text = p0.id,
      items: employees
          .map(
            (e) => DropdownButtonData(
              id: e.empCodigo,
              title: "${e.empNombres} ${e.empApellidos} (${e.empCodigoEmp})",
            ),
          )
          .toList(),
    );
  }
}

class SelectHoursWidget extends StatelessWidget {
  const SelectHoursWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployeesProvider>(context);
    return provider.loadingHours
        ? const CircularProgressIndicator()
        : SelectCompaniesWidget(
            isRequired: false,
            controller: provider.employeeHours,
            title: 'Horario',
            selected: DropdownButtonData(
              id: provider.employeeHours.text,
              title: provider.employeeHours.text,
            ),
            items: [
              ...provider.hoursCtr.map(
                (e) => DropdownButtonData(
                  id: e.horCodigo,
                  title: e.horName,
                ),
              ),
            ],
          );
  }
}

class _SelectContractsWidget extends StatelessWidget {
  const _SelectContractsWidget();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployeesProvider>(context);
    return provider.loading
        ? const CircularProgressIndicator()
        : SelectCompaniesWidget(
            controller: provider.employeeContact,
            isRequired: false,
            isDisable: true,
            title: 'Código de contrato',
            selected: DropdownButtonData(
              id: provider.employeeContact.text,
              title: provider.employeeContact.text,
            ),
            onChange: (val) async {},
            items: [
              ...provider.contractsEmp.map(
                (e) => DropdownButtonData(
                  id: e.ctrCodigo,
                  title: e.ctrNombre,
                ),
              )
            ],
          );
  }
}

class SelectGenderWidget extends StatefulWidget {
  const SelectGenderWidget({
    super.key,
  });

  @override
  State<SelectGenderWidget> createState() => _SelectGenderWidgetState();
}

class _SelectGenderWidgetState extends State<SelectGenderWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployeesProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...provider.genders.map(
          (e) => Padding(
            padding: const EdgeInsets.only(right: 40),
            child: InkWell(
              onTap: () {
                setState(() {
                  provider.employeeGender.text = e.genCodigo;
                });
              },
              child: Row(
                children: [
                  Text(
                    e.genNombre,
                    style: TextStyle(
                      color: getTheme(context).primary,
                      fontSize: 20,
                    ),
                  ),
                  Radio(
                    value: e.genCodigo,
                    groupValue: provider.employeeGender.text,
                    onChanged: (v) {
                      setState(() {
                        provider.employeeGender.text = v!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
