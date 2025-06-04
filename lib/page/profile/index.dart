import 'package:bookingapp/common/app_bar.dart';
import 'package:bookingapp/services/assets.dart';
import 'package:bookingapp/services/themes.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarBooking(title: "Profile", icon: icProfileLogout, onPressed: (){}),
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60.r),
                          child: Image.network("https://res.cloudinary.com/dotz74j1p/raw/upload/v1716044962/tje4vyigverxlotuhvpb.png", width: 120.sp, height: 120.sp, fit: BoxFit.cover)),
                        Positioned(
                          bottom: 5.sp,
                          right: 0,
                          child: Container(
                            width: 27.sp,
                            height: 27.sp,
                            decoration: BoxDecoration(
                              color: Color(primaryColor),
                              borderRadius: BorderRadius.circular(20.r)
                            ),
                            child: Icon(Icons.edit, size: 20.sp, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text("@madun", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400)),
                    Text("Leonel Madun", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400)),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
              _fieldProfile(icProfilePhone, "+62 812 3456 7890"),
              _fieldProfile(icProfileEmail, "madun@gmail.com"),
              _fieldProfile(icLocationPinMap, "Kelapa Gading, Jakarta Utara"),
              _fieldProfile(icProfilePassword, "**********"),
              SizedBox(height: 30.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(110.w, 45.h),
                  backgroundColor: Color(primaryColor),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                ),
                onPressed: () {},
                child: Text("Update", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500))
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _fieldProfile(String pathImage, String value) {
    return Padding(
      padding:EdgeInsets.only(bottom: 20.h),
      child: Stack(
        children: [
          Container(
            height: 55.h,
            width: 300.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 65.w, right: 10.w),
            decoration: BoxDecoration(color: Color(darkGrayColor).withOpacity(0.2), borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r), bottomLeft: Radius.circular(40.r), topRight: Radius.circular(12.r), bottomRight: Radius.circular(12.r))),
            child: Text(value, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400)),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
            height: 55.h,
            width: 55.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Color(0x19000000), blurRadius: 14, offset: Offset(0, 10))
              ],
            ),
            child: Image.asset(pathImage, height: 24.h, width: 24.w)),
          )
        ],
      ),
    );
  }
}

