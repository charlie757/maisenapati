import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatefulWidget {
  String? hintText;
  final TextEditingController controller;
  Widget? prefix;
  final validator;
  List<TextInputFormatter>? inputFormatters;
  bool? isObscureText;
  final TextInputType textInputType;
  final isReadOnly;
  CustomTextfield(
      {key,
      required this.hintText,
      this.validator,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.inputFormatters,
      this.prefix,
      this.isObscureText = false,
      this.isReadOnly = false});
  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        // height: 45,
        child: TextFormField(
          controller: widget.controller,
          readOnly: widget.isReadOnly,
          obscureText: widget.isObscureText!,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.textInputType,
          cursorColor: Colors.black,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          decoration: InputDecoration(
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hintText,
            prefixIcon: widget.prefix,
            hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                // fontFamily: LatoRegular,
                color: Color(0xff989898)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xff403B58),
                ),
                borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}
