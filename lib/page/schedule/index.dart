import 'package:bookingapp/common/app_bar.dart';
import 'package:bookingapp/models/schedule_model.dart';
import 'package:bookingapp/provider/schedule_provider.dart';
import 'package:bookingapp/services/assets.dart';
import 'package:bookingapp/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<ScheduleModel> scheduleListM = [];
  bool _isHeaderFetch = false;

  @override
  void initState() {
    _init();

    super.initState();
  }

  void _init() async {
    await _getSchedule();
  }

  Future<void> _getSchedule() async {
    final scheduleProvider = Provider.of<ScheduleProvider>(context, listen: false);
    setState(() {
      _isHeaderFetch = true;
    });
    print("ttttttttttttttttttttttttt33");
    try {
      final scheduleState = await scheduleProvider.getSchedule();
      if (scheduleState != null) {
        scheduleListM = scheduleState;
      }
      print("ttttttttttttttttttttttttt");
    } catch (e) {
      debugPrint("Error fetching getschedule: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isHeaderFetch = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                AppBarBooking(title: 'Schedule', icon: icScheduleSetting, onPressed: () {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('  ${_monthName(_focusedDay.month)} ${_focusedDay.year}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left, size: 24.sp),
                          onPressed: () {
                            setState(() {
                              _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right, size: 24.sp),
                          onPressed: () {
                            setState(() {
                              _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  headerVisible: false,
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(color: Color(primaryColor), shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(color: Color(primaryColor), shape: BoxShape.circle),
                    selectedTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Schedule", style: TextStyle(fontSize: 16.sp)),
                    Text("See all", style: TextStyle(fontSize: 14.sp, color: Color(primaryColor))),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: _isHeaderFetch ? Center(child: CircularProgressIndicator()) : ListView.builder(
                    itemCount: scheduleListM.length,
                    itemBuilder: (context, index) {
                      final schedule = scheduleListM[index];
                      return _cardSchedule(schedule, index, () => setState(() => scheduleListM.removeAt(index)));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardSchedule(ScheduleModel schedule, int index, VoidCallback onDelete) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Container(
        decoration: BoxDecoration(
          color: Color(primaryRedColor),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Color(lightGrayColor).withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Dismissible(
          key: Key(schedule.id.toString()),
          direction: DismissDirection.startToEnd,
          background: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(color: Color(primaryRedColor), borderRadius: BorderRadius.circular(12.r)),
            child: Icon(Icons.delete, color: Colors.white, size: 24.sp),
          ),
          onDismissed: (direction) {
            onDelete();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(12.r), child: Image.network("${schedule.img}", width: 75.w, height: 75.h, fit: BoxFit.cover)),
                    SizedBox(width: 10.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${schedule.name}", style: TextStyle(fontSize: 14.sp)),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Image.asset(icNavScedule, width: 16.sp, height: 16.sp, color: Color(darkGrayColor)),
                            Text("${schedule.dateTime}", style: TextStyle(fontSize: 12.sp, color: Color(darkGrayColor))),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Text("${schedule.price}", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(primaryColor))),
                            Text(" /night", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Color(darkGrayColor))),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.chevron_right_sharp, size: 30.sp)
              ],
            ),
          ),
        ),
      ),
    );
  }


  String _monthName(int month) {
    const monthNames = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month];
  }
}
