import 'package:amanah_furniture/common/assets.dart';
import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/common/public_function.dart';
import 'package:amanah_furniture/common/validator.dart';
import 'package:amanah_furniture/service/api_service.dart';
import 'package:amanah_furniture/ui/auth/register.dart';
import 'package:amanah_furniture/ui/bottom_navigation/bottom_navigation.dart';
import 'package:amanah_furniture/ui/home_page/home_page.dart';
import 'package:amanah_furniture/ui/widget/auth/login_register_button.dart';
import 'package:amanah_furniture/ui/widget/custom_text_form_field.dart';
import 'package:amanah_furniture/ui/widget/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  BoxShadow _textFieldShadow() => BoxShadow(
      color: Colors.black.withOpacity(0.25),
      offset: Offset(0.w, 4.h),
      blurRadius: 4);
  BoxShadow _imageShadow() => BoxShadow(
      color: Colors.black.withOpacity(0.30),
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
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: screenSize.width,
                height: 250.h,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(30)),
                  boxShadow: [_imageShadow()],
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(30)),
                  child: Image.asset(
                    ImgAssets.loginBackground,
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, 0.17),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    bottom: 5.h,
                    left: 30.w,
                    right: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff555555)),
                      ),
                      Text(
                        "Mulai untuk berbelanja !",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff888888)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _textFieldCase(
                          CustomTextFormField(
                            controller: _emailController,
                            hint: 'Email',
                            textInputType: TextInputType.emailAddress,
                            validator: (value) =>
                                Validator.emailValidator(value),
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
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            text: 'Belum punya akun? ',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => PublicFunction.navigatorPush(
                                      context, Registerpage()),
                                text: 'register',
                                style: const TextStyle(
                                    color: ColorApp.accent,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        LoginRegisterButton(
                          isLogin: true,
                          onPreesed: () async {
                            if (_formKey.currentState!.validate()) {
                              showLoaderDialog(context);
                              bool isSucceed = await ApiService().postLogin(
                                  context,
                                  _emailController.text,
                                  _passwordController.text);
                              Navigator.of(context).pop();
                              isSucceed
                                  ? PublicFunction.navigatorPushAndRemoved(
                                      context, CustomBottomNavigation())
                                  : null;
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
              )
            ],
          ),
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
