import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/services/services.dart';

class GoBackWidget extends StatelessWidget {
  const GoBackWidget({super.key, this.functionn});
  final Function? functionn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: InkWell(
        onTap: () {
          if (functionn != null) {
            functionn!();
          } else {
            NavigationService.goBack();
          }
        },
        child: Row(
          children: [
            Icon(
              Icons.arrow_back,
              color: getTheme(context).primary,
              size: 30,
            ),
            const SizedBox(width: 10),
            const Text(
              "Regresar",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
