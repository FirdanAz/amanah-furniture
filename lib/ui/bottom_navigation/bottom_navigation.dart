import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/ui/home_page/home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();
  int indexPage = 0;
  List<Widget> pages = [
    HomePage(),
    Center(child: Text("Favorit")),
    Center(child: Text("Notifikasi")),
    Center(child: Text("Profil")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[indexPage],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 54.h,
        backgroundColor: Colors.transparent,
        color: ColorApp.accent,
        animationDuration: const Duration(milliseconds: 320),
        onTap: (value) => setState(() {
          indexPage = value;
        }),
        items: [
          Tooltip(
            message: 'Beranda',
            child: Icon(Icons.home, size: 26.r),
          ),
          Tooltip(
            message: 'Favorit',
            child: Icon(Icons.favorite, size: 26.r),
          ),
          Tooltip(
            message: 'Notifikasi',
            child: Icon(Icons.notifications, size: 26.r),
          ),
          Tooltip(
            message: 'Profil',
            child: Icon(Icons.person, size: 26.r),
          ),
        ],
      ),
    );
  }
}
