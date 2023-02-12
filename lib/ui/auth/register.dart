import 'package:amanah_furniture/common/assets.dart';
import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/common/public_function.dart';
import 'package:amanah_furniture/common/validator.dart';
import 'package:amanah_furniture/ui/home_page/home_page.dart';
import 'package:amanah_furniture/ui/widget/auth/login_register_button.dart';
import 'package:amanah_furniture/ui/widget/custom_text_form_field.dart';
import 'package:amanah_furniture/ui/widget/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _teleponController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  BoxShadow _textFieldShadow() => BoxShadow(
      color: Colors.black.withOpacity(0.25),
      offset: Offset(0.w, 4.h),
      blurRadius: 4);

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(backgroundColor: ColorApp.secondary),
          SizedBox(width: 14.w),
          const Text("Loading..."),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(SvgAssets.vectorRegister),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  // height: screenSize.height,
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff555555)),
                              ),
                              Text(
                                "Buatlah akun untuk berbelanja !",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff888888)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _textFieldCase(
                              CustomTextFormField(
                                controller: _usernameController,
                                hint: 'Username',
                                textInputType: TextInputType.emailAddress,
                                validator: (value) =>
                                    Validator.emptyValidator(value),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            _textFieldCase(
                              CustomTextFormField(
                                controller: _emailController,
                                hint: 'Email',
                                validator: (value) =>
                                    Validator.emailValidator(value),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            _textFieldCase(
                              CustomTextFormField(
                                controller: _alamatController,
                                hint: 'Alamat',
                                validator: (value) =>
                                    Validator.emptyValidator(value),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            _textFieldCase(
                              CustomTextFormField(
                                controller: _teleponController,
                                hint: 'No. telepon',
                                textInputType: TextInputType.phone,
                                validator: (value) =>
                                    Validator.teleponValidator(value),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            _textFieldCase(
                              CustomTextFormField(
                                controller: _passwordController,
                                hint: 'Password',
                                isPassword: true,
                                validator: (value) =>
                                    Validator.passwordValidator(value),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            _textFieldCase(
                              CustomTextFormField(
                                controller: _confirmPasswordController,
                                hint: 'Confirm Password',
                                isPassword: true,
                                validator: (value) =>
                                    Validator.passwordValidator(value),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      RichText(
                        text: TextSpan(
                          text: 'Sudah punya akun? ',
                          style:
                              TextStyle(color: Colors.black, fontSize: 14.sp),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pop(context),
                              text: 'Login',
                              style: const TextStyle(
                                  color: ColorApp.accent,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      LoginRegisterButton(
                        isLogin: false,
                        onPreesed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_confirmPasswordController.text !=
                                _passwordController.text) {
                              showSnackBar(
                                context,
                                content: const Text(
                                    'Konfirmasi password dengan benar!'),
                                color: Colors.red,
                              );
                            } else {
                              showLoaderDialog(context);
                              await Future.delayed(Duration(seconds: 2));
                              PublicFunction.navigatorPushAndRemoved(
                                  context, HomePage());
                            }
                          } else {
                            showSnackBar(
                              context,
                              content: const Text(
                                  'Isi form dengan lengkap terlebih dahulu'),
                              color: Colors.red,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldCase(Widget widget) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorApp.primary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [_textFieldShadow()],
      ),
      child: widget,
    );
  }
}
