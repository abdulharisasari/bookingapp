
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import '../../common/app_bar.dart';
import '../../routers/arguments.dart';
import '../../services/assets.dart';
import '../../services/themes.dart';

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
                  top: 30.sp,
                  left: 20.sp,
                  right: 20.sp,
                  child: AppBarBooking(title: "Detail", titleColor: Colors.white, icon: icDetailMenu, onPressed: () {}),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 140.w, right: 140.w, top: 10.h, bottom: 35.h),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.zero, bottomRight: Radius.zero, topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r))),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.detailArgument?.name}", style: TextStyle(fontSize: 16.sp)),
                      Row(
                        children: [
                          Text("\$${widget.detailArgument?.price}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Color(primaryColor))),
                          Text(" /night", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)),
                        ],
                      ),                      
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Image.asset(icDetailPinOutline, width: 24.sp, height: 24.sp, color: Color(primaryColor)),
                      Text(" Alice Springs NT 0870, Australia", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text("Description", style: TextStyle(fontSize: 14.sp)),
                  ReadMoreText(
                    'Aston Hotel, Alice Springs NT 0870, Australia is a modern hotel. Elegant 5 star hotel overlooking the sea. Perfect for a romantic, charming experience. ',
                    trimLines: 2,
                    colorClickableText: Color(primaryColor),
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Show less',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                    moreStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Color(primaryColor)),
                    lessStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Color(primaryColor)),),
                  SizedBox(height: 10.h),
                  Text("Preview", style: TextStyle(fontSize: 14.sp)),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 65.h,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 10.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12.r)),
                            child: Image.network(
                              "https://picsum.photos/200/300?random=$index",
                              width: 100.sp,
                              height: 65.sp,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 60.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(primaryColor),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {},
                      child: Text("Booking Now", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomReadMoreText extends StatefulWidget {
  final String text;
  final int trimLines;
  final TextStyle? style;
  final TextStyle? moreLessStyle;

  const CustomReadMoreText({
    required this.text,
    this.trimLines = 2,
    this.style,
    this.moreLessStyle,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomReadMoreText> createState() => _CustomReadMoreTextState();
}

class _CustomReadMoreTextState extends State<CustomReadMoreText> {
  bool _readMore = true;

  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(text: widget.text, style: widget.style);
    final tp = TextPainter(
      text: textSpan,
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    final bool isOverflowing = tp.didExceedMaxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: widget.style,
          maxLines: _readMore ? widget.trimLines : null,
          overflow: _readMore ? TextOverflow.clip : TextOverflow.visible,
        ),
        if (isOverflowing)
          GestureDetector(
            onTap: () {
              setState(() {
                _readMore = !_readMore;
              });
            },
            child: Text(
              _readMore ? 'Read more' : 'Show less',
              style: widget.moreLessStyle ??
                  TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(primaryColor),
                  ),
            ),
          ),
      ],
    );
  }
}
