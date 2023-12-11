import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';

class NotDataWidget extends StatelessWidget {
  const NotDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      // padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Image.asset("assets/icons/no_employes.png"),
          const SizedBox(height: 20),
          Text(
            "Sin datos",
            style: TextStyle(
              color: getTheme(context).tertiary,
              fontWeight: FontWeight.w400,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
