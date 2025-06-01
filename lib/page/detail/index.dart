import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routers/arguments.dart';

class DetailPage extends StatefulWidget {
  final DetailArgument? detailArgument;
  const DetailPage({super.key, this.detailArgument});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(widget.detailArgument?.img ?? '', width: double.infinity, height: 416.h, fit: BoxFit.cover),
                Positioned(
                  top: 40,
                  left: 0,
                  right: 0,
                  child: Center(child: Text("Detail", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                ),
                Positioned(bottom: 0, right: 0, left: 0, child: Container(height: 50.h, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.zero, bottomRight: Radius.zero, topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)))))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
