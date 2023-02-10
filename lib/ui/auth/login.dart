import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/common/public_function.dart';
import 'package:amanah_furniture/service/api_service.dart';
import 'package:amanah_furniture/ui/home_page/home_page.dart';
import 'package:amanah_furniture/ui/widget/auth/login_register_button.dart';
import 'package:amanah_furniture/ui/widget/custom_text_form_field.dart';
import 'package:amanah_furniture/ui/widget/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class LoginPart extends StatefulWidget {
  final VoidCallback onTap;

  const LoginPart({super.key, required this.onTap});

  @override
  State<LoginPart> createState() => _LoginPartState();
}

class _LoginPartState extends State<LoginPart> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
    return Form(
      key: _formKey,
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
          SizedBox(height: 25.h),
          DecoratedBox(
            decoration: BoxDecoration(
              color: ColorApp.primary,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [_textFieldShadow()],
            ),
            child: CustomTextFormField(
              controller: _emailController,
              hint: 'Email',
              textInputType: TextInputType.emailAddress,
              validator: (value) => PublicFunction.emailValidator(value),
            ),
          ),
          SizedBox(height: 24.h),
          DecoratedBox(
            decoration: BoxDecoration(
              color: ColorApp.primary,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [_textFieldShadow()],
            ),
            child: CustomTextFormField(
              controller: _passwordController,
              hint: 'Password',
              isPassword: true,
              validator: (value) => PublicFunction.passwordValidator(value),
            ),
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = widget.onTap,
                  text: 'register',
                  style: const TextStyle(
                      color: ColorApp.accent, fontWeight: FontWeight.w500),
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
                    context, _emailController.text, _passwordController.text);
                Navigator.of(context).pop();
                isSucceed
                    ? PublicFunction.navigatorPushAndRemoved(
                        context, HomePage())
                    : null;
              } else {
                showSnackBar(
                  context,
                  content:
                      const Text('Isi form dengan lengkap terlebih dahulu'),
                  color: Colors.red,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
