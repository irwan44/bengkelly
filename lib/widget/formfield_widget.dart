import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.onChange,
    this.initialValue,
    this.showCursor = false,
    this.cursorColor,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
    this.onFieldSubmitted,
  }) : super(
    key: key,
  );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor, cursorColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final bool readOnly, showCursor;

  final Function()? onTap;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final String? initialValue;

  final TextCapitalization textCapitalization;

  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: textFormFieldWidget(context),
    )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) =>
      SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          textCapitalization: textCapitalization,
          scrollPadding:
          EdgeInsets.only(bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom),
          controller: controller,
          cursorColor: cursorColor,
          showCursor: showCursor,
          initialValue: initialValue,
          style: textStyle ?? ThemeData().textTheme.bodyLarge,
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
          autovalidateMode: autovalidateMode,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChange,
          onFieldSubmitted:onFieldSubmitted,
        ),
      );

  InputDecoration get decoration =>
      InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? ThemeData().textTheme.bodyLarge,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
        fillColor: fillColor ?? appTheme.gray50,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.primaryContainer,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.primaryContainer,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.colorScheme.primaryContainer,
                width: 1,
              ),
            ),
      );
}
