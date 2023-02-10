import 'package:amanah_furniture/common/assets.dart';
import 'package:amanah_furniture/ui/auth/login.dart';
import 'package:amanah_furniture/ui/auth/register.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  BoxShadow _imageShadow() => BoxShadow(
      color: Colors.black.withOpacity(0.30),
      offset: Offset(0.w, 4.h),
      blurRadius: 4);

  void toggle() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: isLogin
                      ? LoginPart(onTap: toggle)
                      : RegisterPart(onTap: toggle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
