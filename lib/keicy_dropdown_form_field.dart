import 'package:flutter/material.dart';

class KeicyDropDownFormField<T> extends StatelessWidget {
  final FocusNode? focusNode;
  final List<dynamic>? items;
  final T? value;
  final TextStyle? itemStyle;
  final TextStyle? selectedItemStyle;
  final Color? dropdownColor;
  final InputBorder border;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isDense;
  final bool isCollapsed;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final void Function(T?)? onSaved;
  final void Function()? onTap;

  const KeicyDropDownFormField({
    Key? key,
    this.focusNode,
    @required this.items,
    this.value,
    this.itemStyle,
    this.selectedItemStyle,
    this.dropdownColor,
    this.border = const OutlineInputBorder(),
    this.focusedBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.contentPadding,
    this.isDense = true,
    this.isCollapsed = false,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      focusNode: focusNode,
      items: items!.map((item) {
        if (item.runtimeType.toString() == "String") {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString(), style: itemStyle),
          );
        } else {
          return DropdownMenuItem<T>(
            value: item["value"],
            child: Text(item["text"], style: itemStyle),
          );
        }
      }).toList(),
      selectedItemBuilder: (BuildContext context) {
        return items!.map<Widget>((item) {
          return Text(
            (item.runtimeType.toString() == "String") ? item.toString() : item["text"],
            style: selectedItemStyle ?? itemStyle,
          );
        }).toList();
      },
      value: value,
      dropdownColor: dropdownColor,
      decoration: InputDecoration(
        border: border,
        focusedBorder: focusedBorder,
        enabledBorder: border,
        disabledBorder: disabledBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: focusedErrorBorder,
        contentPadding: contentPadding,
        isDense: isDense,
        isCollapsed: isCollapsed,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: hintText,
        labelStyle: labelStyle,
        floatingLabelBehavior: floatingLabelBehavior,
      ),
      onChanged: (T? value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      validator: (T? value) {
        if (validator != null) {
          return validator!(value);
        }

        return null;
      },
      onSaved: (T? value) {
        if (onSaved != null) {
          onSaved!(value);
        }
      },
      onTap: onTap,
    );
  }
}
