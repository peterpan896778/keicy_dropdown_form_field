library keicy_dropdown_form_field;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeicyDropDownFormField extends FormField<dynamic> {
  KeicyDropDownFormField({
    Key key,
    @required double width,
    @required double height,
    @required List<Map<String, dynamic>> menuItems,
    @required Function(dynamic) onChangeHandler,
    bool isDense: true,
    bool isExpanded: true,
    dynamic value,
    bool autovalidate: false,
    FormFieldValidator<dynamic> onValidateHandler,
    Function onSaveHandler,

    /// label
    String label = "",
    double labelTextFontSize,
    double labelColor,
    double labelSpacing = 5,

    /// icons
    List<Widget> prefixIcons = const [],
    List<Widget> suffixIcons = const [],
    bool isPrefixIconOutofField = false,
    bool isSuffixIconOutofField = false,
    double iconSpacing = 10,
    double iconSize = 20,

    /// border
    Color fillColor = Colors.white,
    Border border = const Border(bottom: BorderSide(width: 1, color: Colors.black)),
    Border errorBorder = const Border(bottom: BorderSide(width: 1, color: Colors.red)),
    double borderRadius = 0,
    // textfield
    double contentHorizontalPadding = 5,
    double contentVerticalPadding = 5,
    bool isfixedHeight = true,
    double itemTextFontSize = 15,
    Color itemTextColor = Colors.black,
    double selectedItemTextFontSize,
    Color selectedItemTextColor,
    Color dropdownColor = Colors.white,
    String hintText = "",
    double hintTextFontSize,
    Color hintTextColor = Colors.grey,
    bool fixedHeightState = true,
    bool isDoneValidate = false,
  }) : super(
          key: key,
          initialValue: value,
          autovalidate: autovalidate,
          validator: (value) {
            isDoneValidate = true;
            if (onValidateHandler != null) return onValidateHandler(value);
            return null;
          },
          onSaved: onSaveHandler,
          builder: (FormFieldState<dynamic> state) {
            return MultiProvider(
              providers: [ChangeNotifierProvider(create: (context) => KeicyDropDownFormFieldProvider(value))],
              child: Consumer<KeicyDropDownFormFieldProvider>(
                builder: (context, customDropDownFormFieldProvider, _) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                    if (customDropDownFormFieldProvider.isDoneValidate != isDoneValidate) customDropDownFormFieldProvider.setIsDoneValidate(true);
                  });
                  Widget prefixIcon = SizedBox();
                  Widget suffixIcon = SizedBox();
                  if (prefixIcons.length != 0 && !state.hasError && customDropDownFormFieldProvider.isDoneValidate)
                    prefixIcon = prefixIcons[0];
                  else if (prefixIcons.length != 0) prefixIcon = prefixIcons[1] ?? prefixIcons[0];

                  if (suffixIcons.length != 0 && !state.hasError && customDropDownFormFieldProvider.isDoneValidate)
                    suffixIcon = suffixIcons[0];
                  else if (suffixIcons.length != 0) suffixIcon = suffixIcons[1] ?? suffixIcons[0];

                  return Container(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        (label == "")
                            ? SizedBox()
                            : Text(
                                label,
                                style: TextStyle(
                                  fontSize: labelTextFontSize ?? itemTextFontSize,
                                  color: labelColor ?? selectedItemTextColor ?? itemTextColor,
                                ),
                              ),
                        (label == "") ? SizedBox() : SizedBox(height: labelSpacing),
                        Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            color: fillColor,
                            border: (state.hasError) ? errorBorder : border,
                            borderRadius: border.isUniform && errorBorder.isUniform ? BorderRadius.circular(borderRadius) : null,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding, vertical: contentVerticalPadding),
                          child: Row(
                            children: <Widget>[
                              (!isPrefixIconOutofField) ? prefixIcon : SizedBox(),
                              (!isPrefixIconOutofField && prefixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                              Expanded(
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  items: menuItems
                                      .map((item) => DropdownMenuItem(
                                            child: new Text(item["text"], style: TextStyle(fontSize: itemTextFontSize, color: itemTextColor)),
                                            value: item["value"],
                                          ))
                                      .toList(),
                                  selectedItemBuilder: (BuildContext context) {
                                    return menuItems.map<Widget>((item) {
                                      return Text(
                                        item["text"],
                                        style: TextStyle(
                                          fontSize: selectedItemTextFontSize ?? itemTextFontSize,
                                          color: selectedItemTextColor ?? itemTextColor,
                                        ),
                                      );
                                    }).toList();
                                  },
                                  dropdownColor: dropdownColor,
                                  hint: Text(
                                    hintText,
                                    style:
                                        TextStyle(fontSize: hintTextFontSize ?? selectedItemTextFontSize ?? itemTextFontSize, color: hintTextColor),
                                  ),
                                  isDense: isDense,
                                  isExpanded: isExpanded,
                                  value: customDropDownFormFieldProvider.value,
                                  iconSize: iconSize,
                                  onChanged: (value) {
                                    onChangeHandler(value);
                                    customDropDownFormFieldProvider.setValue(value);
                                    state.didChange(value);
                                  },
                                ),
                              ),
                              (!isSuffixIconOutofField && suffixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                              (!isSuffixIconOutofField) ? suffixIcon : SizedBox(),
                            ],
                          ),
                        ),
                        (state.hasError)
                            ? Container(
                                height: (selectedItemTextFontSize ?? itemTextFontSize) + 5,
                                child: Text(
                                  (state.errorText ?? ""),
                                  style: TextStyle(fontSize: (selectedItemTextFontSize ?? itemTextFontSize) * 0.8, color: Colors.red),
                                ),
                              )
                            : (fixedHeightState) ? SizedBox(height: (selectedItemTextFontSize ?? itemTextFontSize) + 5) : SizedBox(),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
}

class KeicyDropDownFormFieldProvider extends ChangeNotifier {
  static KeicyDropDownFormFieldProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<KeicyDropDownFormFieldProvider>(context, listen: listen);

  KeicyDropDownFormFieldProvider(value) {
    _value = value;
  }

  dynamic _value;
  dynamic get value => _value;
  void setValue(dynamic value) {
    if (_value != value) {
      _value = value;
    }
  }

  bool _isDoneValidate = false;
  bool get isDoneValidate => _isDoneValidate;
  void setIsDoneValidate(bool isDoneValidate) {
    if (_isDoneValidate != isDoneValidate) {
      _isDoneValidate = isDoneValidate;
    }
  }
}
