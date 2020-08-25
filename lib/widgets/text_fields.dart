import 'package:flutter/material.dart';

class OutlineBorderedTFWithIcon extends StatelessWidget {
  final String hint;
  final String label;
  final int validateLength;
  final Function(String) onChange;
  final Function(String) validator;
  final Function(String) save;
  final bool isObscure;
  final TextInputType textInputType;
  final int maxLength;
  final TextEditingController controller;
  final int maxLines;
  final IconData suffixIcon;
  final String initialValue;
  final EdgeInsets contentPadding;
  final Widget suffix;
  final Color borderColor;
  final IconData icon;
  final double iconSize;

  const OutlineBorderedTFWithIcon(
      {Key key,
      this.hint,
      this.label,
      this.validateLength,
      this.onChange,
      this.validator,
      this.save,
      this.isObscure,
      this.textInputType,
      this.maxLength,
      this.controller,
      this.maxLines,
      this.suffixIcon,
      this.initialValue,
      this.contentPadding =
          const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      this.suffix,
      this.borderColor = Colors.white,
      this.icon,
      this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      scrollPhysics: PageScrollPhysics(),
      controller: controller,
      validator: validator ??
              (value) {
            if (validateLength == 0) return null;
            if (value == null) return "Invalid input";

            if (value.length < validateLength)
              return "${label ?? "Input"} must be valid";

            return null;
          },
      textAlign: label.toLowerCase().contains("otp")
          ? TextAlign.center
          : TextAlign.left,
      toolbarOptions: ToolbarOptions(
        copy: true,
        cut: true,
        paste: true,
        selectAll: true,
      ),
      obscureText: isObscure ?? false,
      onSaved: save,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      keyboardType: textInputType,
      initialValue: initialValue,
      cursorColor: Theme
          .of(context)
          .primaryColor,
      decoration: InputDecoration(
        suffix: suffix,
        prefixIcon: Icon(
          icon,
          size: iconSize,
        ),
        contentPadding: contentPadding,
        hintText: hint ?? ' ',
        labelText: label ?? ' ',
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        border: InputBorder.none,
      ),
    );
  }
}

class OutlinedTextField extends StatelessWidget {
  final String hint;
  final String label;
  final int validateLength;
  final Function(String) onChange;
  final Function(String) validator;
  final Function(String) save;
  final bool isObscure;
  final TextInputType textInputType;
  final int maxLength;
  final TextEditingController controller;
  final int maxLines;
  final IconData suffixIcon;
  final String initialValue;
  final EdgeInsets padding, contentPadding;
  final Widget suffix;

  const OutlinedTextField({Key key,
    this.hint,
    this.label,
    this.validateLength,
    this.save,
    this.isObscure,
    this.maxLength,
    this.controller,
    this.maxLines,
    this.initialValue,
    this.suffixIcon,
    this.padding = const EdgeInsets.all(0.0),
    this.suffix,
    this.contentPadding =
    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
    this.textInputType,
    this.validator,
    this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: padding,
        child: TextFormField(
          onChanged: onChange,
          scrollPhysics: PageScrollPhysics(),
          controller: controller,
          validator: validator ??
                  (value) {
                if (validateLength == 0) return null;
                if (value == null) return "Invalid input";

                if (value.length < validateLength)
                  return "${label ?? "Input"} must be valid";

                return null;
              },
          textAlign: label.toLowerCase().contains("otp")
              ? TextAlign.center
              : TextAlign.left,
          toolbarOptions: ToolbarOptions(
            copy: true,
            cut: true,
            paste: true,
            selectAll: true,
          ),
          obscureText: isObscure ?? false,
          onSaved: save,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          keyboardType: textInputType,
          initialValue: initialValue,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffix: suffix,
              contentPadding: contentPadding,
//              counterText: "",
              hintText: hint ?? ' ',
              labelText: label ?? ' ',
              suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null),
        ),
      ),
    );
  }
}
