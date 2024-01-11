import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/models/dropdown_button_data_model.dart';
import 'package:marcacion_admin/src/common/services/services.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/contract/viewmodel/contracts_provider.dart';
import 'package:marcacion_admin/src/modules/dashboard/view/widgets/bar_graph_widget.dart';
import 'package:marcacion_admin/src/modules/dashboard/view/widgets/chat_status_widget.dart';
import 'package:marcacion_admin/src/modules/dashboard/view/widgets/pie_chart_widget.dart';
import 'package:marcacion_admin/src/modules/dashboard/viewmodel/dashboard_provider.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BreadCrumbsWidget(
              title: 'Dashboard',
            ),
            SizedBox(height: 20),
            BodyDashboardWidget(),
          ],
        ),
      ),
    );
  }
}

class BodyDashboardWidget extends StatelessWidget {
  const BodyDashboardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: secondary40,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.only(top: 20),
          child: const Wrap(
            children: [
              CardUserCustomerWidget(),
              EmployeeOntimeWidget(),
              EmployeeLaetWidget(),
              EmployeeExtrasHoursWidget(),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Wrap(
          children: [
            CharMonthWidget(),
            CharGenderWidget(),
            CharStatusWidget(),
          ],
        )
      ],
    );
  }
}

class EmployeeOntimeWidget extends StatelessWidget {
  const EmployeeOntimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provDash = Provider.of<DashboardProvider>(context);
    return Employees1Widget(
      title: 'Marcaciones a tiempo',
      icon: 'user_check.svg',
      valor1: provDash.time?.onTime.toString() ?? '0',
      valor2: '',//provDash.time?.total.toString() ?? '0',
      valor3:double.parse( provDash.time?.onTime != null && provDash.time?.total != null
          ? ((provDash.time!.onTime / provDash.time!.total) * 100).toString()
          : '0').toStringAsFixed(2),
      color: (provDash.time?.onTime.toString() ?? '0') == '0' ? primary : success,
    );
  }
}

class EmployeeLaetWidget extends StatelessWidget {
  const EmployeeLaetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provDash = Provider.of<DashboardProvider>(context);
    return Employees1Widget(
      title: 'Marcaciones con retraso',
      icon: 'user_minus.svg',
      valor1: provDash.time?.inLate.toString() ?? '0',
      valor2: '',//provDash.time?.total.toString() ?? '0',
      valor3:double.parse( provDash.time?.inLate != null && provDash.time?.total != null
          ? ((provDash.time!.inLate / provDash.time!.total) * 100).toString()
          : '0').toStringAsFixed(2),
      color: (provDash.time?.inLate.toString() ?? '0') == '0' ? primary : error,
    );
  }
}

class EmployeeExtrasHoursWidget extends StatelessWidget {
  const EmployeeExtrasHoursWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var provDash = Provider.of<DashboardProvider>(context);
    return Employees1Widget(
      title: 'Empleados horas extra',
      icon: 'alarm.svg',
      valor1: provDash.extraHours?.extraHours.toString() ?? '0',
      valor2: provDash.extraHours?.extraHoursC.toString() ?? '0',
      valor3: provDash.extraHours?.extraHours != null &&
              provDash.extraHours?.extraHoursC != null
          ? ((provDash.extraHours!.extraHours /
                      provDash.extraHours!.extraHoursC) *
                  100)
              .toString()
          : '0',
      color: (provDash.extraHours?.extraHoursC.toString() ?? '0') == '0'
          ? primary
          : success,
    );
  }
}

class CharMonthWidget extends StatelessWidget {
  const CharMonthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 450,
      margin: const EdgeInsets.only(right: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: ,
        border: Border.all(
          color: const Color(0XFFEFEFEF),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const LineChartAsisten(),
    );
  }
}

class CharGenderWidget extends StatelessWidget {
  const CharGenderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 450,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        // color: ,
        border: Border.all(
          color: const Color(0XFFEFEFEF),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const PieChartGenderWidget(),
    );
  }
}

class CharStatusWidget extends StatelessWidget {
  const CharStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 610,
      height: 450,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        // color: ,
        border: Border.all(
          color: const Color(0XFFEFEFEF),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const ChartStatusWidget(),
    );
  }
}

class Employees1Widget extends StatelessWidget {
  const Employees1Widget({
    super.key,
    required this.title,
    required this.icon,
    this.valor1 = "0",
    this.valor2 = "",
    this.valor3 = "",
    this.color = primary,
  });
  final String title;
  final String icon;
  final Color color;
  final String valor1;
  final String valor2;
  final String valor3;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset("assets/icons/$icon"),
          SvgPicture.asset("assets/svg/$icon", semanticsLabel: 'Acme Logo'),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
              color: getTheme(context).primary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                valor1,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: getTheme(context).primary,
                ),
              ),
              if (valor2.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "/ de $valor2",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: getTheme(context).secondary.withOpacity(0.8),
                    ),
                  ),
                ),
            ],
          ),
          Text(
            "$valor3%",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          const Text(
            "vs el mes pasado.",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: secondary60,
            ),
          ),
        ],
      ),
    );
  }
}

class CardUserCustomerWidget extends StatelessWidget {
  const CardUserCustomerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hola, ${LocalStorage.prefs.getString('nombres') ?? ""} ${LocalStorage.prefs.getString('apellidos') ?? ""}",
            style: TextStyle(
              color: getTheme(context).primary,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 40),
          const Wrap(
            children: [
              Text(
                "Estas son ",
                style: TextStyle(
                  color: secondary80,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "las estadísticas diarias",
                style: TextStyle(
                  color: secondary80,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "según el proyecto seleccionado",
                style: TextStyle(
                  color: secondary80,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: getTheme(context).primary,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Selecciona un contrato",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 55,
                  child: const _SelectContratWidget(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SelectContratWidget extends StatelessWidget {
  const _SelectContratWidget();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContractsProvider>(context, listen: false);
    var provDash = Provider.of<DashboardProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.getContracts(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
          controller: provider.companyFilter,
          title: '',
          onChange: (val) {
            provDash.getChartsData(val.id);
          },
          textSelected: 'Seleccione una opcion por favor',
          items: [
            if (snapshot.data != null)
              ...provider.contracts.map(
                (e) => DropdownButtonData(
                  id: e.ctrCodigo,
                  title: e.ctrName,
                ),
              )
          ],
        );
      },
    );
  }
}
