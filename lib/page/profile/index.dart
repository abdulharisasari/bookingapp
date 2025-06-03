import 'package:bookingapp/common/app_bar.dart';
import 'package:bookingapp/services/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
              children: [
                AppBarBooking(title: "Profile", icon: icProfileLogout, onPressed: (){}),
              ],
          ),
        ),
      ),
    );
  }
}