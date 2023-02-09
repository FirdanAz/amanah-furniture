import 'package:amanah_furniture/common/color_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class LoginRegisterButton extends StatelessWidget {
  final bool isLogin;
  final Function() onPreesed;

  const LoginRegisterButton(
      {super.key, this.isLogin = false, required this.onPreesed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPreesed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: isLogin ? ColorApp.accent : ColorApp.secondary,
        ),
        child: isLogin
            ? Text(
                'Login',
                style: TextStyle(
                  color: ColorApp.primary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            : Text(
                'Register',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
