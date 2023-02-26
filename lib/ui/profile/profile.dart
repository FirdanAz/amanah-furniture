import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/common/public_function.dart';
import 'package:amanah_furniture/model/user_model.dart';
import 'package:amanah_furniture/service/api_service.dart';
import 'package:amanah_furniture/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? _userModel;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
  final TextStyle _textStyle1 =
      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600);

  void _logOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "Ingin keluar dari akun ini ?",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("No")),
            TextButton(
                onPressed: () async => await PublicFunction.removeToken('token')
                    .then((value) => PublicFunction.navigatorPushAndRemoved(
                        context, const LoginPage())),
                child: const Text("Yes", style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }

  Future _getData() async {
    _userModel = await ApiService().getUser(context);
    isLoading.value = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 58.h,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (context, value, _) {
              return value
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {},
                      splashRadius: 22.r,
                      icon: const Icon(Icons.edit_note,
                          size: 30, color: ColorApp.primary));
            },
          )
        ],
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, value, _) => value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                    height: 174.h,
                    child: Stack(
                      children: [
                        Container(color: ColorApp.accent, height: 105.h),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 122.h,
                            width: 122.w,
                            padding: EdgeInsets.all(5.r),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorApp.primary),
                            child: CircleAvatar(
                              backgroundColor: ColorApp.secondary,
                              child: Text(
                                PublicFunction.getInitials(
                                    _userModel!.username),
                                style: TextStyle(
                                    fontSize: 34.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(_userModel!.username, style: _textStyle1),
                  SizedBox(height: 6.h),
                  Text(_userModel!.email, style: _textStyle1),
                  SizedBox(height: 40.h),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 27.w, vertical: 31.h),
                      decoration: BoxDecoration(
                        color: ColorApp.primary,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.r)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 20)
                        ],
                      ),
                      child: Column(
                        children: [
                          _button(Icons.person, 'Informasi Akun',
                              () => print("click")),
                          SizedBox(height: 24.h),
                          _button(Icons.paste, 'Status Pembelian',
                              () => print("click")),
                          SizedBox(height: 24.h),
                          _button(Icons.history, 'Riwayat Order',
                              () => print("click")),
                          SizedBox(height: 24.h),
                          _button(Icons.info, 'Tentang', () => print("click")),
                          SizedBox(height: 24.h),
                          _button(Icons.logout, 'Log Out', _logOut),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget _button(IconData icon, String text, Function() onTap) {
    Color color =
        text == 'Log Out' ? Color.fromARGB(192, 255, 82, 82) : ColorApp.accent;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            Icon(icon, color: color, size: 36.r),
            SizedBox(width: 16.w),
            Text(text, style: _textStyle1.copyWith(color: color)),
            text == 'Log Out' ? const SizedBox() : const Spacer(),
            text == 'Log Out'
                ? const SizedBox()
                : Icon(Icons.chevron_right, color: color, size: 30.r)
          ],
        ),
      ),
    );
  }
}
