import 'dart:async';
import 'package:amanah_furniture/common/public_function.dart';
import 'package:amanah_furniture/ui/auth/login.dart';
import 'package:amanah_furniture/ui/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/common/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<bool> _isTextOn = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isVectorOn = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isFirstTimeOn = ValueNotifier<bool>(false);

  Future _autoAnimate() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isVectorOn.value = !_isVectorOn.value;
    await Future.delayed(const Duration(milliseconds: 580));
    _isTextOn.value = !_isTextOn.value;
    await Future.delayed(const Duration(seconds: 2));
    if (await PublicFunction.getToken() == '') {
      PublicFunction.navigatorPushReplacement(context, LoginPage());
    } else {
      PublicFunction.navigatorPushReplacement(context, HomePage());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _autoAnimate();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: _isVectorOn,
              builder: (context, value, _) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOutCubic,
                  left: _isVectorOn.value ? 0.w : -120.w,
                  top: _isVectorOn.value ? 0.h : -120.h,
                  child: SvgPicture.asset(SvgAssets.vector1SplashScreen),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: _isVectorOn,
              builder: (context, value, _) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOutCubic,
                  right: _isVectorOn.value ? 0.w : -120.w,
                  bottom: _isVectorOn.value ? 0.h : -120.h,
                  child: SvgPicture.asset(SvgAssets.vector2SplashScreen),
                );
              },
            ),
            Center(
              child: ValueListenableBuilder(
                valueListenable: _isTextOn,
                builder: (context, value, child) {
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _isTextOn.value ? 1 : 0,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 30.sp, fontFamily: 'Kurale'),
                        children: const [
                          TextSpan(
                              text: 'Amanah',
                              style: TextStyle(color: ColorApp.accent)),
                          TextSpan(
                              text: ' Furniture',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: ValueListenableBuilder(
            //     valueListenable: _isFirstTimeOn,
            //     builder: (context, value, _) {
            //       return AnimatedOpacity(
            //         duration: const Duration(milliseconds: 200),
            //         opacity: _isFirstTimeOn.value ? 1 : 0,
            //         child: ElevatedButton(
            //           onPressed: () {
            //             setState(() {
            //               firstTime = !firstTime;
            //             });
            //             PublicFunction.navigatorPushReplacement(
            //                 context, AuthPage());
            //           },
            //           child: Text("Lanjut?"),
            //         ),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
