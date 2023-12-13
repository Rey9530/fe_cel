import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcacion_admin/src/common/const/const.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/widgets/widgets.dart';
import 'package:marcacion_admin/src/modules/contract/model/index.dart';
import 'package:marcacion_admin/src/modules/contract/viewmodel/contracts_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class EditListHoursWidgets extends StatelessWidget {
  const EditListHoursWidgets({
    super.key,
    required this.schedule,
  });
  final ListHoursCtr schedule;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ItemHoursWidget(
          schedule: schedule,
        ),
      ],
    );
  }
}

class _ItemHoursWidget extends StatelessWidget {
  const _ItemHoursWidget({
    required this.schedule,
  });
  final ListHoursCtr schedule;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContractsProvider>(context);
    return Stack(
      children: [
        Container(
          width: 975,
          height: 575,
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColorContainers,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              BtnDeleteScheduleWidget(
                onTab: () {
                  final dialog = AlertDialog(
                    title: Column(
                      children: [
                        Image.asset("assets/icons/borrarred.png"),
                        Text(
                          'Eliminar ${schedule.horName}',
                          style: const TextStyle(color: error),
                        ),
                      ],
                    ),
                    content: const Text(
                      '¿Confirmas que deseas eliminar este horario?',
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
                              Provider.of<ContractsProvider>(context,
                                      listen: false)
                                  .deleteSchedule(schedule.horCodigo);

                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  );

                  showDialog(context: context, builder: (_) => dialog);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var day in schedule.marHdeDetailHo)
                    _DayItemWidget(item: day),
                ],
              ),
              BtnWidget(
                width: 200,
                loading: provider.loading,
                title: "Actualizar",
                onPress: () async {
                  await provider.updateScheduleContract(schedule);
                },
              )
            ],
          ),
        ),
        Positioned(
          left: 50,
          top: 10,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.white,
            child: Text(
              schedule.horName,
              style: TextStyle(
                color: getTheme(context).primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BtnDeleteScheduleWidget extends StatelessWidget {
  const BtnDeleteScheduleWidget({
    super.key,
    required this.onTab,
  });
  final Function onTab;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerRight,
      width: double.infinity,
      child: SizedBox(
        width: 80,
        child: InkWell(
          onTap: () {
            onTab();
          },
          child: const Row(
            children: [
              Icon(
                Icons.close,
                color: Color(0XFFFF9C02),
              ),
              Text(
                "Eliminar",
                style: TextStyle(
                  color: Color(0XFFFF9C02),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DayItemWidget extends StatelessWidget {
  const _DayItemWidget({
    required this.item,
  });
  final MarHdeDetailHo item;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ContractsProvider>(context);
    return SizedBox(
      width: 135,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (item.hdeStart1.isEmpty || item.hdeFin1.isEmpty)
                  ? colorContainers
                  : getTheme(context).primary,
              border: Border.all(
                width: 1,
                color: getTheme(context).primary,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (item.hdeStart1.isNotEmpty && item.hdeFin1.isNotEmpty) ...[
                  Image.asset("assets/icons/check_white.png"),
                  const SizedBox(width: 5),
                ],
                Text(
                  item.marDiaDias.diaName,
                  style: TextStyle(
                    color: (item.hdeStart1.isEmpty || item.hdeFin1.isEmpty)
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 80,
            child: TextFormFieldCustomWidget(
              isDark: true,
              readOnly: true,
              label: "Entrada",
              hinText: '00:00',
              controller: TextEditingController(
                text: convertTimeToAmPm(item.hdeStart1),
              ),
              onChange: (valor) {},
              suffixIcon: InkWell(
                onTap: () {
                  var dialog = _DialogTimeWidget(
                    currentTime: convertTimeToAmPm(item.hdeStart1),
                    onChange: (String valor) {
                      item.hdeStart1 = valor;
                      provider.notifyListens();
                    },
                  );
                  showDialog(context: context, builder: (_) => dialog);
                },
                child: Image.asset("assets/icons/alarm-plus.png"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 80,
            child: TextFormFieldCustomWidget(
              isDark: true,
              readOnly: true,
              label: "Salida",
              hinText: '00:00',
              controller:
                  TextEditingController(text: convertTimeToAmPm(item.hdeFin1)),
              onChange: (valor) {},
              suffixIcon: InkWell(
                onTap: () {
                  var dialog = _DialogTimeWidget(
                    currentTime: convertTimeToAmPm(item.hdeFin1),
                    onChange: (String valor) {
                      item.hdeFin1 = valor;
                      provider.notifyListens();
                    },
                  );
                  showDialog(context: context, builder: (_) => dialog);
                },
                child: Image.asset("assets/icons/alarm-plus.png"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 1,
            width: double.infinity,
            color: Colors.black,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 80,
            child: TextFormFieldCustomWidget(
              isDark: true,
              readOnly: true,
              label: "Entrada",
              hinText: '00:00',
              controller: TextEditingController(
                  text: convertTimeToAmPm(item.hdeStart2)),
              onChange: (valor) {},
              suffixIcon: InkWell(
                onTap: () {
                  var dialog = _DialogTimeWidget(
                    currentTime: convertTimeToAmPm(item.hdeStart2),
                    onChange: (String valor) {
                      item.hdeStart2 = valor;
                      provider.notifyListens();
                    },
                  );
                  showDialog(context: context, builder: (_) => dialog);
                },
                child: Image.asset("assets/icons/alarm-plus.png"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 80,
            child: TextFormFieldCustomWidget(
              isDark: true,
              readOnly: true,
              label: "Salida",
              hinText: '00:00',
              controller:
                  TextEditingController(text: convertTimeToAmPm(item.hdeFin2)),
              onChange: (valor) {},
              suffixIcon: InkWell(
                onTap: () {
                  var dialog = _DialogTimeWidget(
                    currentTime: convertTimeToAmPm(item.hdeFin2),
                    onChange: (String valor) {
                      item.hdeFin2 = valor;
                      provider.notifyListens();
                    },
                  );
                  showDialog(context: context, builder: (_) => dialog);
                },
                child: Image.asset("assets/icons/alarm-plus.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogTimeWidget extends StatelessWidget {
  _DialogTimeWidget({
    required this.onChange,
    this.currentTime = '',
  });
  final Function(String) onChange;
  final String currentTime;
  final hora = TextEditingController();
  final minutes = TextEditingController();
  final turn = TextEditingController(text: 'AM');
  @override
  Widget build(BuildContext context) {
    var split = currentTime.split(":");
    if (split.length > 1) {
      hora.text = split[0];
      minutes.text = split[1][0] + split[1][1];
      turn.text = split[1][2] + split[1][3];
    }

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: SizedBox(
        height: 161,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ingresa la hora",
              style: TextStyle(color: textGray),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 126,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 81,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldCustomWidget(
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          fontSize: 40,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 5,
                          ),
                          isDark: true,
                          label: '',
                          controller: hora,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            MaskTextInputFormatter(
                              mask: '#%',
                              filter: {
                                "#": RegExp(r'[0-1]'),
                                "%": RegExp(r'[0-9]'),
                              },
                              type: MaskAutoCompletionType.lazy,
                            ),
                          ],
                        ),
                        const Text(
                          "Horas",
                          style: TextStyle(color: textGray),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 30,
                    height: 75,
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Text(
                      ":",
                      style: TextStyle(
                        fontSize: 40,
                        color: getTheme(context).primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 81,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldCustomWidget(
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          fontSize: 40,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 5,
                          ),
                          isDark: true,
                          label: '',
                          controller: minutes,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            MaskTextInputFormatter(
                              mask: '#%',
                              filter: {
                                "#": RegExp(r'[0-5]'),
                                "%": RegExp(r'[0-9]'),
                              },
                              type: MaskAutoCompletionType.lazy,
                            ),
                          ],
                        ),
                        const Text(
                          "Minutos",
                          style: TextStyle(color: textGray),
                        ),
                      ],
                    ),
                  ),
                  AMPMWidget(
                    value: turn.text,
                    onChange: (String valor) {
                      turn.text = valor;
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancelar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: getTheme(context).primary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                var h = hora.text.length == 1 ? "0${hora.text}" : hora.text;
                var m = minutes.text.length == 1
                    ? "0${minutes.text}"
                    : minutes.text;
                onChange("$h:$m${turn.text}");
                Navigator.pop(context);
              },
              child: Text(
                " OK ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: getTheme(context).primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AMPMWidget extends StatefulWidget {
  const AMPMWidget({
    super.key,
    required this.onChange,
    this.value = 'AM',
  });
  final Function(String) onChange;
  final String value;
  @override
  State<AMPMWidget> createState() => _AMPMWidgetState();
}

class _AMPMWidgetState extends State<AMPMWidget> {
  bool isAM = true;
  @override
  void initState() {
    super.initState();
    isAM = widget.value == 'AM';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isAM = true;
              });
              widget.onChange("AM");
            },
            child: Container(
              width: 80,
              height: 42,
              decoration: BoxDecoration(
                color: isAM ? getTheme(context).primary : Colors.white,
                border: Border.all(
                  width: 1,
                  color: getTheme(context).primary,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "AM",
                style: TextStyle(
                  color: isAM ? Colors.white : getTheme(context).primary,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isAM = false;
              });
              widget.onChange("PM");
            },
            child: Container(
              width: 80,
              height: 42,
              decoration: BoxDecoration(
                color: isAM ? Colors.white : getTheme(context).primary,
                border: Border.all(
                  width: 1,
                  color: getTheme(context).primary,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "PM",
                style: TextStyle(
                  color: isAM ? getTheme(context).primary : Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
