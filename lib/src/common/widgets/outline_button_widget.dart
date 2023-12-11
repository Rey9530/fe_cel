import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/const/const.dart';

class BtnOutlineWidget extends StatelessWidget {
  const BtnOutlineWidget({
    super.key,
    this.width = double.infinity,
    this.height = 50,
    required this.title,
    required this.onPress,
    this.disable = false,
    this.loading = false,
  });
  final double? width;
  final bool disable;
  final bool loading;

  final String title;
  final double height;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        alignment: Alignment.center,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: primary,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: primary,
          ),
        ),
      ),
    );
  }
}
