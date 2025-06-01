import 'package:bookingapp/page/home/index.dart';
import 'package:bookingapp/page/profile/index.dart';
import 'package:bookingapp/services/assets.dart';
import 'package:bookingapp/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../page/location/index.dart';
import '../page/schedule/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final pages = [
    HomePage(),
    LocationPage(),
    SchedulePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.sp),
        child: pages[_selectedIndex],
      )),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              index: 0,
              label: 'Home',
              iconOutline: icNavHome,
              icon: icNavHomeOn,
            ),
            _buildNavItem(
              index: 1,
              label: 'Location',
              iconOutline: icNavLocation,
              icon: icNavLocationOn,
            ),
            _buildNavItem(
              index: 2,
              label: 'Schedule',
              iconOutline: icNavScedule,
              icon: icNavScheduleOn,
            ),
            _buildNavItem(
              index: 3,
              label: 'Profile',
              iconOutline: icNavProfile,
              icon: icNavProfileOn,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required int index, required String label, required String icon, required String iconOutline}) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF522504).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Image.asset(isSelected ? icon: iconOutline, color: Color(primaryColor),height: 20.h,width: 20.w),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF522504),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
