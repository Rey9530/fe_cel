import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/companies/model/companies_dts.dart';
import 'package:marcacion_admin/src/modules/companies/viewmodel/companies_provider.dart';
import 'package:provider/provider.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CompaniesProvider()),
        ],
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: const [
            BreadCrumWidget(
              title: 'Empresas',
            ),
            _BodyCompaniesWidget(),
          ],
        ),
      ),
    );
  }
}

class _BodyCompaniesWidget extends StatelessWidget {
  const _BodyCompaniesWidget();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text(
            "Agregar nueva empresa",
            style: TextStyle(
              color: getTheme(context).primary,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Completa los campos para agregar una nueva empresa. Al terminar da clic en el botón “Guardar”.",
            style: TextStyle(
              color: getTheme(context).primary,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 50),
          const _EmployesFormWidget(),
          const ListEmployesWidget()
        ],
      ),
    );
  }
}

class _EmployesFormWidget extends StatefulWidget {
  const _EmployesFormWidget();

  @override
  State<_EmployesFormWidget> createState() => _EmployesFormWidgetState();
}

class _EmployesFormWidgetState extends State<_EmployesFormWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompaniesProvider>(context);
    return Form(
      key: provider.formKey,
      child: Column(
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: 600,
                child: TextFormFieldCustomWidget(
                  isDark: true,
                  // onFieldSubmitted: (_) => onFormSubmit(providerAuth),
                  // cursorColor: Colors.white,
                  label: "Nombre de la empresa",
                  hinText: 'Escribe el nombre de la empresa',
                  controller: provider.companyName,
                  onChange: (valor) {
                    provider.validarInput();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: 350,
                child: TextFormFieldCustomWidget(
                  isDark: true,
                  // onFieldSubmitted: (_) => onFormSubmit(providerAuth),
                  // cursorColor: Colors.white,
                  label: "Dirección de la empresa",
                  hinText: 'Escribe el la dirección de la empresa',
                  controller: provider.companyAdress,
                  onChange: (valor) {
                    provider.validarInput();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: 350,
                child: TextFormFieldCustomWidget(
                  isDark: true,
                  // onFieldSubmitted: (_) => onFormSubmit(providerAuth),
                  // cursorColor: Colors.white,
                  label: "Persona de contacto",
                  hinText: 'Escribe el nombre de la persona a contactar ',
                  controller: provider.companyContact,
                  onChange: (valor) {
                    provider.validarInput();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: 600,
                child: TextFormFieldCustomWidget(
                  isDark: true,
                  // onFieldSubmitted: (_) => onFormSubmit(providerAuth),
                  // cursorColor: Colors.white,
                  label: "Correo electrónico",
                  hinText:
                      'Escribe el correo de la persona de la empresa a contactar',
                  controller: provider.companyEmail,
                  onChange: (valor) {
                    provider.validarInput();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: 350,
                child: TextFormFieldCustomWidget(
                  isDark: true,
                  // onFieldSubmitted: (_) => onFormSubmit(providerAuth),
                  // cursorColor: Colors.white,
                  label: "Teléfono de contacto",
                  hinText: 'Escribe el teléfono de la persona de contacto ',
                  controller: provider.companyPhone,
                  onChange: (valor) {
                    provider.validarInput();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: 350,
                child: BtnWidget(
                  title: 'Guardar',
                  disable: !(provider.isReady),
                  loading: provider.loading,
                  onPress: () async {
                    if (provider.formKey.currentState?.validate() ?? false) {
                      await provider.postCompanies();
                      provider.formKey.currentState?.reset();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}

class ListEmployesWidget extends StatefulWidget {
  const ListEmployesWidget({
    super.key,
  });

  @override
  State<ListEmployesWidget> createState() => _ListEmployesWidgetState();
}

class _ListEmployesWidgetState extends State<ListEmployesWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<CompaniesProvider>(context, listen: false).getCompanies();
  }

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompaniesProvider>(context);
    var style = TextStyle(
      fontWeight: FontWeight.w600,
      color: getTheme(context).primary,
    );
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: PaginatedDataTable(
          headingRowColor: MaterialStateColor.resolveWith(
              (states) => const Color(0XFFF3F3F4)),
          columns: [
            DataColumn(label: Text('Nombre de la empresa', style: style)),
            DataColumn(label: Text('Dirección de la empresa', style: style)),
            DataColumn(label: Text('Persona de contacto', style: style)),
            DataColumn(label: Text('Correo electrónico', style: style)),
            DataColumn(label: Text('Teléfono de contacto', style: style)),
            DataColumn(label: Text('Acciones', style: style)),
          ],
          // header: const SizedBox(),
          // arrowHeadColor: const Color(0XFFF3F3F4),
          source: CompanieTDS(provider.companies, context),
          onRowsPerPageChanged: (value) {
            setState(() {
              _rowsPerPage = value ?? 10;
            });
          },
          horizontalMargin: 10,
          rowsPerPage: _rowsPerPage,
          // actions: [
          //   CustomIconButton(
          //     onPressed: () {
          //       showModalBottomSheet(
          //           backgroundColor: Colors.transparent,
          //           context: context,
          //           builder: (_) => CategoryModal(categoria: null));
          //     },
          //     text: 'Crear',
          //     icon: Icons.add_outlined,
          //   )
          // ],
        ),
      ),
    );
  }
}
