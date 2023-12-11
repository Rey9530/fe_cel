import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcacion_admin/src/common/const/styles.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';

class TextFormFieldCustomWidget extends StatefulWidget {
  const TextFormFieldCustomWidget({
    super.key,
    required this.label,
    required this.controller,
    this.hinText,
    this.isPassword = false,
    this.keyboardType = TextInputType.none,
    this.cursorColor,
    this.onChange,
    this.onFieldSubmitted,
    this.isDark = false,
    this.autofocus = false,
    this.readOnly = false,
    this.suffixIcon,
    this.contentPadding,
    this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.start,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.inputFormatters,
  });
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;
  final bool isDark;
  final bool autofocus;
  final bool readOnly;
  final Function? onChange;
  final Function(String)? onFieldSubmitted;
  final String label;
  final String? hinText;
  final TextInputType keyboardType;
  final bool isPassword;
  final Color? cursorColor;
  final TextEditingController controller;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  @override
  State<TextFormFieldCustomWidget> createState() =>
      _TextFormFieldCustomWidgetState();
}

class _TextFormFieldCustomWidgetState extends State<TextFormFieldCustomWidget> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  bool showText = true;
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: widget.textAlign,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      inputFormatters: widget.inputFormatters,
      onFieldSubmitted: widget.onFieldSubmitted,
      cursorColor: widget.isDark ? getTheme(context).primary : Colors.white,
      controller: widget.controller,
      obscureText: (widget.isPassword && showText),
      focusNode: _focus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? valor) {
        var data = (valor == null || valor.isEmpty)
            ? "Este campo es requerido "
            : null;
        return data;
      },
      onChanged: (valor) {
        setState(() {
          isError = (valor.isEmpty);
        });
        if (widget.onChange != null) {
          widget.onChange!(valor);
        }
      },
      style: TextStyle(
        color: widget.isDark ? getTheme(context).primary : Colors.white,
        fontWeight: widget.fontWeight,
        fontSize: widget.fontSize,
      ),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    showText = !showText;
                  });
                },
                child: showText
                    ? Icon(
                        Icons.visibility_off,
                        color: (_focus.hasFocus ||
                                widget.controller.text.isNotEmpty)
                            ? widget.isDark
                                ? getTheme(context).primary
                                : Colors.white
                            : (widget.isDark
                                    ? getTheme(context).primary
                                    : Colors.white)
                                .withOpacity(0.6),
                      )
                    : Icon(
                        Icons.visibility,
                        color: (_focus.hasFocus ||
                                widget.controller.text.isNotEmpty)
                            ? widget.isDark
                                ? getTheme(context).primary
                                : Colors.white
                            : (widget.isDark
                                    ? getTheme(context).primary
                                    : Colors.white)
                                .withOpacity(0.6),
                      ),
              )
            : widget.suffixIcon,
        labelText: widget.label,
        hintText: widget.hinText,
        hintStyle: const TextStyle(color: hintextPassword),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDark ? getTheme(context).primary : Colors.white,
            width: 4,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: error,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDark ? getTheme(context).primary : Colors.white,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDark ? getTheme(context).primary : Colors.white,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: error,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: (_focus.hasFocus || widget.controller.text.isNotEmpty)
              ? widget.isDark
                  ? getTheme(context).primary
                  : Colors.white
              : (widget.isDark ? getTheme(context).primary : Colors.white),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
