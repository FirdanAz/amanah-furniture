import 'package:amanah_furniture/common/theme_app.dart';
import 'package:amanah_furniture/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        title: 'Amanah Furniture',
        debugShowCheckedModeBanner: false,
        theme: ThemeApp.getTheme(context),
        home: SplashScreen(),
      ),
      // child: const LoginPage(),
    );
  }
}
