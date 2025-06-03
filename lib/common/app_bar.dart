import 'package:bookingapp/routers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/themes.dart';

class AppBarBooking extends StatefulWidget {
  final Color? titleColor;
  final String title, icon;
  final void Function() onPressed;
  const AppBarBooking({super.key, this.titleColor,required this.title, required this.icon, required this.onPressed});

  @override
  State<AppBarBooking> createState() => _AppBarBookingState();
}

class _AppBarBookingState extends State<AppBarBooking> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(40.w, 40.h),
              padding: EdgeInsets.zero,
              backgroundColor: Color(primaryColor),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, mainRoute, (route) => false);
            },
            child: Icon(Icons.chevron_left, size: 24.sp),
          ),
          Text(
            "${widget.title}",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: widget.titleColor ?? Colors.black,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(40.w, 40.h),
              padding: EdgeInsets.all(5.sp),
              backgroundColor: Color(primaryColor),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            onPressed: () {},
            child: Image.asset("${widget.icon}",color: Colors.white, width: 18.w, height: 18.h, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
