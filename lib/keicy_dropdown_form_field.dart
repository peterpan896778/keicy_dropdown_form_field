import 'package:flutter/material.dart';

class KeicyDropDownFormField<T> extends StatelessWidget {
  final FocusNode? focusNode;
  final List<dynamic>? items;
  final T? value;
  final TextStyle? itemStyle;
  final TextStyle? selectedItemStyle;
  final Color? dropdownColor;
  final Color? focusColor;
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
  final bool isImport;
  final Widget? icon;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? iconSize;
  final double? maxWidth;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool? disabled;
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
    this.focusColor,
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
    this.isImport = false,
    this.icon,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.iconSize,
    this.maxWidth,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.disabled = false,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputBorder _border;
    InputBorder _disabledBorder;
    InputBorder _focusedBorder;
    InputBorder _errorBorder;
    InputBorder _focusedErrorBorder;

    _border = border;

    if (disabledBorder == null) {
      _disabledBorder = _border;
      _disabledBorder = _disabledBorder.copyWith(
        borderSide: _disabledBorder.borderSide.copyWith(color: Colors.grey.withOpacity(0.7)),
      );
    } else {
      _disabledBorder = disabledBorder!;
    }

    if (focusedBorder == null) {
      _focusedBorder = _border;
      _focusedBorder = _focusedBorder.copyWith(
        borderSide: _focusedBorder.borderSide.copyWith(width: 1.5),
      );
    } else {
      _focusedBorder = focusedBorder!;
    }

    if (errorBorder == null) {
      _errorBorder = _border;
      _errorBorder = _errorBorder.copyWith(borderSide: _errorBorder.borderSide.copyWith(color: Colors.red));
    } else {
      _errorBorder = errorBorder!;
    }

    if (focusedErrorBorder == null) {
      _focusedErrorBorder = _errorBorder;
      _focusedErrorBorder = _focusedErrorBorder.copyWith(
        borderSide: _focusedErrorBorder.borderSide.copyWith(width: 1.5),
      );
    } else {
      _focusedErrorBorder = focusedErrorBorder!;
    }

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
          return Container(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? double.infinity,
            ),
            child: Text(
              (item.runtimeType.toString() == "String") ? item.toString() : item["text"],
              style: selectedItemStyle ?? itemStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList();
      },
      value: value,
      dropdownColor: dropdownColor,
      focusColor: focusColor,
      decoration: InputDecoration(
        border: _border,
        focusedBorder: _focusedBorder,
        enabledBorder: _border,
        disabledBorder: _disabledBorder,
        errorBorder: _errorBorder,
        focusedErrorBorder: _focusedErrorBorder,
        contentPadding: contentPadding,
        isDense: isDense,
        isCollapsed: isCollapsed,
        hintText: hintText,
        hintStyle: hintStyle,
        label: labelText != null
            ? Wrap(
                children: [
                  Text("$labelText", style: labelStyle),
                  if (isImport && labelText != null)
                    Text(
                      "  *",
                      style: labelStyle != null
                          ? labelStyle!.copyWith(color: Colors.red, fontWeight: FontWeight.bold)
                          : Theme.of(context).inputDecorationTheme.labelStyle!.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                ],
              )
            : null,
        labelText: null,
        labelStyle: null,
        floatingLabelBehavior: floatingLabelBehavior,
      ),
      icon: icon,
      iconDisabledColor: iconDisabledColor,
      iconEnabledColor: iconEnabledColor,
      iconSize: iconSize ?? 24,
      onChanged: disabled!
          ? null
          : (T? value) {
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
