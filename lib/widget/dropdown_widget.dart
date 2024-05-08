import 'package:flutter/material.dart';

import '../utils/app_theme.dart';
import '../utils/general_function.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.alignment,
    this.width,
    this.value,
    this.onChange,
    this.item,
    this.hintText,
  });

  final Alignment? alignment;
  final double? width;
  final String? value;
  final Function(Object? value)? onChange;
  final List<DropdownMenuItem<Object>>? item;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: dropdownFormFieldWidget(context),
          )
        : dropdownFormFieldWidget(context);
  }

  Widget dropdownFormFieldWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
    child: DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: theme.colorScheme.primaryContainer,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: theme.colorScheme.primaryContainer,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: theme.colorScheme.primaryContainer,
              width: 1,
            ),
          ),
          isDense: true,
          fillColor: appTheme.gray50,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 30,
        ),
        isExpanded: true,
        value: value,
        hint: Text(hintText!),
        style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
        validator: (value) => value == null ? 'Field is Required' : null,
        onTap: () => dismissTextFieldFocus(),
        onChanged: (value) {
          onChange!(value);
          // setState(() {
          //   _selectedMerk = value.toString();
          //   getTypeByMerk(value.toString());
          //   debugPrint(_selectedMerk);
          // });
        },
        items: item,
      ),
    ),
      );
}
