import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';
import 'package:marcacion_admin/src/common/models/dropdown_button_data_model.dart';

class SearchDropdowWidget extends StatefulWidget {
  const SearchDropdowWidget({
    super.key,
    required this.controller,
    required this.title,
    required this.items,
    this.textSelected = 'Selecciona una opción',
    this.selected,
    this.onChange,
    this.onFind,
    this.isRequired = true,
    this.isDisable = false,
  });
  final List<DropdownButtonData>? items;
  final DropdownButtonData? selected;
  final String title;
  final String textSelected;
  final bool isRequired;
  final bool isDisable;
  final TextEditingController controller;
  final Function(DropdownButtonData)? onChange;
  final Function(String)? onFind;
  @override
  State<SearchDropdowWidget> createState() => _SearchDropdowWidgetState();
}

class _SearchDropdowWidgetState extends State<SearchDropdowWidget> {
  String dropdownvalue = '0';
  List<DropdownButtonData> items = [];
  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      dropdownvalue = widget.selected?.id ?? '0';
      var ifExist = widget.items
          ?.where((element) => element.id == dropdownvalue)
          .toList();
      if (ifExist != null && ifExist.isEmpty) {
        dropdownvalue = '0';
      }
    }
    items = [
      ...[
        DropdownButtonData(title: widget.textSelected, id: '0'),
      ],
      if (widget.items != null && widget.items!.isNotEmpty) ...widget.items!
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      // filterFn: (item, filter) {
      //   return item.title.toLowerCase().startsWith(filter.toLowerCase());
      // },
      asyncItems: (text) async {
        if (widget.onFind != null) {
          await widget.onFind!(text);
          await Future.delayed(const Duration(milliseconds: 100));
        }
        setState(() {});
        return widget.items!.map(
          (e) {
            return e;
          },
        ).toList();
      },
      dropdownBuilder: (BuildContext context, DropdownButtonData? item) {
        if (item != null && items.isNotEmpty) {
          return Text(item.title);
        }
        return Text(widget.textSelected);
      },
      popupProps: PopupProps.menu(
        isFilterOnline: true,
        showSearchBox: true,
        showSelectedItems: true,
        itemBuilder:
            (BuildContext context, DropdownButtonData item, bool isSelected) {
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.id),
            selected: isSelected,
          );
        },
      ),
      compareFn: (item1, item2) {
        return item1.id == item2.id;
      },

      dropdownDecoratorProps: _decoration(context),
      onChanged: (v) {
        print(v?.id);
        if (widget.onChange != null && v != null) {
          widget.onChange!(v);
        }
      },
      // selectedItem: widget.selected,
    );
  }

  DropDownDecoratorProps _decoration(BuildContext context) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        labelText: widget.title,
        errorStyle: const TextStyle(height: 0.4),
        labelStyle: TextStyle(
          color: widget.isDisable
              ? getTheme(context).tertiary.withOpacity(0.5)
              : getTheme(context).primary,
          fontWeight: FontWeight.w400,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: getTheme(context).error,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: getTheme(context).error,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDisable
                ? getTheme(context).tertiary.withOpacity(0.5)
                : getTheme(context).tertiary.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDisable
                ? getTheme(context).tertiary.withOpacity(0.5)
                : getTheme(context).primary,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDisable
                ? getTheme(context).tertiary.withOpacity(0.5)
                : getTheme(context).primary,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: getTheme(context).tertiary.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
