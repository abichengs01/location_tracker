import 'package:data_base/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_layout.dart';
import '../config/app_style.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final TextStyle? errorStyle;
  final TextEditingController? control;
  final TextInputType? inputkeybordtype;
  final int? length;
  final Widget? iconfunction;
  final bool? obstext;
  final bool? readonly;
  final Widget? prefix;
  final Widget? suffixIcon;
  final TextAlign align;
  final int? lines;
  final FormFieldValidator? value;
  final List<TextInputFormatter>? formatter;
  final VoidCallback? function;
  final Function(String)? onChanged;
  final TextAlignVertical vertAlign;
  final bool? fill;
  final bool autoFocus;
  final FocusNode? focusNode;
  final Color? borderColor;

  const MyTextField({
    Key? key,
    required this.hint,
    this.control,
    this.function,
    required this.inputkeybordtype,
    required this.length,
    this.iconfunction,
    this.obstext,
    this.prefix,
    this.lines = 1,
    this.value,
    this.formatter,
    // required this.autoFocus,
    required this.suffixIcon,
    required this.align,
    required this.vertAlign,
    this.readonly,
    this.errorStyle,
    this.onChanged,
    this.fill,
    this.autoFocus = false,
    this.focusNode,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onChanged: onChanged,
      readOnly: readonly ?? false,
      validator: value,
      style: AppStyle(context).headingMediumBold.copyWith(
            letterSpacing: 0.9,
          ),
      autofocus: autoFocus,
      inputFormatters: formatter,
      controller: control,
      keyboardType: inputkeybordtype,
      maxLength: length,
      maxLines: lines,
      obscureText: obstext ?? false,
      textAlign: align,
      textAlignVertical: vertAlign,
      cursorColor: AppColor.primary,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorStyle: errorStyle,
        contentPadding: const EdgeInsets.all(12),
        counterText: "",
        prefixIcon: prefix,
        hintText: hint,
        prefixStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppLayout.cornerRadius),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppLayout.cornerRadius),
          ),
          borderSide: BorderSide(color: borderColor ?? Colors.black12),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppLayout.cornerRadius),
          ),
          borderSide: BorderSide(color: Colors.red),
        ),
        suffixIcon: suffixIcon,
      ),
      onTap: function,
    );
  }
}
