import 'package:amanah_furniture/common/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hint,
    this.textInputType = TextInputType.text,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordNotVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autocorrect: true,
      enableSuggestions: true,
      obscureText: widget.isPassword ? _isPasswordNotVisible : false,
      keyboardType: widget.textInputType,
      validator: widget.validator,
      style: TextStyle(
          color: const Color(0xff555555),
          fontSize: 13.sp,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: ColorApp.accent)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
            color: const Color(0xff777777),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400),
        suffixIcon: widget.isPassword
            ? IconButton(
                padding: EdgeInsets.zero,
                splashRadius: 20,
                iconSize: 20.w,
                onPressed: () {
                  setState(() {
                    _isPasswordNotVisible = !_isPasswordNotVisible;
                  });
                },
                icon: _isPasswordNotVisible
                    ? const Icon(
                        Icons.visibility_off,
                        color: Color(0xff888888),
                      )
                    : const Icon(
                        Icons.visibility,
                        color: Color(0xff888888),
                      ),
              )
            : null,
      ),
    );
  }
}
