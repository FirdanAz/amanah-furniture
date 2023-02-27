import 'package:amanah_furniture/common/color_app.dart';
import 'package:amanah_furniture/common/public_function.dart';
import 'package:amanah_furniture/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformasiAkunPage extends StatelessWidget {
  InformasiAkunPage({super.key, required this.userModel});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final UserModel userModel;
  final TextStyle _titleStyle =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
  final TextStyle _contentStyle = TextStyle(fontSize: 12.sp);

  @override
  Widget build(BuildContext context) {
    usernameController.text = userModel.username;
    emailController.text = userModel.email;
    alamatController.text = userModel.alamat;
    phoneController.text = userModel.noHp;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 58.h,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.chevron_left,
                size: 30, color: ColorApp.primary)),
        title: Text(
          'Profile',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: Column(
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
                        shape: BoxShape.circle, color: ColorApp.primary),
                    child: CircleAvatar(
                      backgroundColor: ColorApp.secondary,
                      child: Text(
                        PublicFunction.getInitials(userModel.username),
                        style: TextStyle(
                            fontSize: 34.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 41.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _contentField(
                    controller: usernameController, title: 'Username'),
                SizedBox(height: 19.h),
                _contentField(controller: emailController, title: 'Email'),
                SizedBox(height: 19.h),
                _contentField(controller: alamatController, title: 'Alamat'),
                SizedBox(height: 19.h),
                _contentField(controller: phoneController, title: 'Telepon'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _contentField(
          {required TextEditingController controller, required String title}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _titleStyle),
          SizedBox(height: 2.h),
          TextField(
            controller: controller,
            readOnly: true,
            enabled: false,
            maxLines: null,
            style: _contentStyle,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffA9A9A9))),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffA9A9A9))),
            ),
          )
        ],
      );
}
