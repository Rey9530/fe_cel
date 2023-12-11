import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/models/dropdown_buttom_data_model.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/employees/viewmodel/employes_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class AddEmployeView extends StatelessWidget {
  const AddEmployeView({super.key, this.uuid});
  final String? uuid;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployesProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.getCatalogos(uuid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return const AddEmployeBodyWidget();
      },
    );
  }
}

class AddEmployeBodyWidget extends StatelessWidget {
  const AddEmployeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployesProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          BreadCrumWidget(
            title:
                'Empleados / ${provider.uuid != null ? "${provider.employeName.text} ${provider.employeSurname.text}" : "Nuevo empleado"}',
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
              "Completa los campos. Al terminar da clic en el botón “Guardar”.",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 50),
          const _FormewEmployeWidget()
        ],
      ),
    );
  }
}

class _FormewEmployeWidget extends StatelessWidget {
  const _FormewEmployeWidget();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployesProvider>(context);
    return Form(
      key: provider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 1100,
            child: Wrap(
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
                        "TER-${provider.employeCode}",
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 400,
                  child: TextFormFieldCustomWidget(
                    isDark: true,
                    label: "Nombres",
                    hinText: 'Escribe los nombres del nuevo empleado',
                    controller: provider.employeName,
                    onChange: (valor) {
                      // provider.validarInput();
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 400,
                  child: TextFormFieldCustomWidget(
                    isDark: true,
                    label: "Apellidos",
                    hinText: 'Escribe los apellidos del nuevo empleado',
                    controller: provider.employeSurname,
                    onChange: (valor) {
                      // provider.validarInput();
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 200,
                  child: TextFormFieldCustomWidget(
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '##/##/####',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy,
                      ),
                    ],
                    isDark: true,
                    label: "Fecha de nacimiento",
                    hinText: '00/00/0000',
                    controller: provider.employeBirthdate,
                    onChange: (String valor) async {
                      if (valor.length < 10) return;
                      try {
                        await provider.generateCode(valor);
                      } catch (e) {
                        return;
                      }
                      // provider.validarInput();
                    },
                    suffixIcon: InkWell(
                      onTap: () async {
                        var data = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now().add(
                            const Duration(days: -6570),
                          ),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          locale: const Locale('es', 'ES'),
                        );
                        if (data != null) {
                          String onlydate =
                              DateFormat("dd/MM/yyyy").format(data);
                          provider.employeBirthdate.text = onlydate;
                          String birthDate =
                              DateFormat("yyyy-MM-dd").format(data);
                          await provider.generateCode(birthDate);
                        }
                      },
                      child: Image.asset("assets/icons/calendar_primary.png"),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 405,
                  child: const SelectGenderWidget(),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 620,
                  child: SelectCompaniesWidget(
                    controller: provider.employeLocation,
                    title: 'Sede asignada',
                    onChange: (val) {},
                    selected: DropdownButtonData(
                      id: provider.employeLocation.text,
                      title: provider.employeLocation.text,
                    ),
                    items: [
                      ...provider.sedes.map(
                        (e) => DropdownButtonData(
                          id: e.ubiCodigo,
                          title: e.ubiNombre,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 400,
                  child: SelectCompaniesWidget(
                    controller: provider.employeCompany,
                    title: 'Empresa',
                    onChange: (val) async {
                      await provider.getContracts(val.id);
                    },
                    selected: DropdownButtonData(
                      id: provider.employeCompany.text,
                      title: provider.employeCompany.text,
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 400,
                  child: const _SelectContractsWidget(),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 200,
                  child: const SelectHoursWidget(),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 400,
                  child: SelectCompaniesWidget(
                    controller: provider.employeContratation,
                    title: 'Tipo de contratación',
                    selected: DropdownButtonData(
                      id: provider.employeContratation.text,
                      title: provider.employeContratation.text,
                    ),
                    items: [
                      ...provider.contratations.map(
                        (e) => DropdownButtonData(
                          id: e.conCodigo,
                          title: e.conNombre,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 400,
                  child: TextFormFieldCustomWidget(
                    isDark: true,
                    label: "Fecha de inicio",
                    hinText: '00/00/0000',
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '##/##/####',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy,
                      ),
                    ],
                    controller: provider.employeDateStart,
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
                          String onlydate =
                              DateFormat("dd/MM/yyyy").format(data);
                          provider.employeDateStart.text = onlydate;
                        }
                      },
                      child: Image.asset("assets/icons/calendar_primary.png"),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 200,
                  child: TextFormFieldCustomWidget(
                    isDark: true,
                    label: "Fecha de fin",
                    hinText: '00/00/0000',
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '##/##/####',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy,
                      ),
                    ],
                    controller: provider.employeDateEnd,
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
                          String onlydate =
                              DateFormat("dd/MM/yyyy").format(data);
                          provider.employeDateStart.text = onlydate;
                        }
                      },
                      child: Image.asset("assets/icons/calendar_primary.png"),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: BtnWidget(
                    width: 200,
                    height: 60,
                    loading: provider.loading,
                    title: "Guardar",
                    onPress: () async {
                      // provider.saveEmploye();
                      if (provider.formKey.currentState?.validate() ?? false) {
                        await provider.saveEmploye();
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SelectHoursWidget extends StatelessWidget {
  const SelectHoursWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EmployesProvider>(context);
    return provider.loadingHours
        ? const CircularProgressIndicator()
        : SelectCompaniesWidget(
            controller: provider.employeHours,
            title: 'Horario',
            selected: DropdownButtonData(
              id: provider.employeHours.text,
              title: provider.employeHours.text,
            ),
            items: [
              ...provider.hoursCtr.map(
                (e) => DropdownButtonData(
                  id: e.horCodigo,
                  title: e.horNombre,
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
    var provider = Provider.of<EmployesProvider>(context);
    return provider.loading
        ? const CircularProgressIndicator()
        : SelectCompaniesWidget(
            controller: provider.employeContact,
            isRequired: false,
            title: 'Código de contrato',
            selected: DropdownButtonData(
              id: provider.employeContact.text,
              title: provider.employeContact.text,
            ),
            onChange: (val) async {
              await provider.getHoursContracts(val.id);
            },
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
    var provider = Provider.of<EmployesProvider>(context, listen: false);
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
                  provider.employeGender.text = e.genCodigo;
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
                    groupValue: provider.employeGender.text,
                    onChanged: (v) {
                      setState(() {
                        provider.employeGender.text = v!;
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
