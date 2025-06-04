import 'package:bookingapp/models/hotel_model.dart';
import 'package:bookingapp/provider/hotel_provider.dart';
import 'package:bookingapp/routers/arguments.dart';
import 'package:bookingapp/routers/constants.dart';
import 'package:bookingapp/services/assets.dart';
import 'package:bookingapp/services/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  List<HotelModel> hotelModelList = [];
  List<HotelModel> leftColumn = [];
  List<HotelModel> rightColumn = [];
  bool _isHeaderFetch = false;

  late ScrollController _leftScrollController;
  late ScrollController _rightScrollController;
  String selectedCategory = 'Hotel';
  
  
  @override
  void initState() {
    super.initState();
    
    _init();
  }

  void _init() async {
    await _getOrderReport();
    _leftScrollController = ScrollController();
    _rightScrollController = ScrollController(initialScrollOffset: 130);
    _splitHotelList();
  }

  void _splitHotelList() {
    leftColumn.clear();
    rightColumn.clear();
    for (int i = 0; i < hotelModelList.length; i++) {
      if (i % 2 == 0) {
        leftColumn.add(hotelModelList[i]);
      } else {
        rightColumn.add(hotelModelList[i]);
      }
    }
    setState(() {});
  }

  Future<void> _getOrderReport() async {
    final hotelProv = Provider.of<HotelProvider>(context, listen: false);
    setState(() {
      _isHeaderFetch = true;
    });
    try {
      final hotalState = await hotelProv.getHotel();
      if (hotalState != null) {
        hotelModelList = hotalState;
      }
      _splitHotelList();
    } catch (e) {
      debugPrint("catch _getOrderReport -- $e");
    } finally {
      if (mounted) {
        setState(() {
          _isHeaderFetch = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _leftScrollController.dispose();
    _rightScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 24.sp, color: Color(primaryColor)),
                      SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current location",
                            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                          ),
                          Text(
                            "Jakarta, ID",
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.sp, color: Color(0xFFECECEC)),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications_none_outlined, size: 22.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 54.h,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryBadge("Hotel"),
                      _buildCategoryBadge("Homestay"),
                      _buildCategoryBadge("Apartment"),                   
                      _buildCategoryBadge("Villa"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: _isHeaderFetch ? Center(child: CircularProgressIndicator()): Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _leftScrollController,
                        itemCount: leftColumn.length,
                        itemBuilder: (context, index) {
                          final hotel = leftColumn[index];
                          return _buildHotelCard(hotel);
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ListView.builder(
                        controller: _rightScrollController,
                        itemCount: rightColumn.length,
                        itemBuilder: (context, index) {
                          final hotel = rightColumn[index];
                          return _buildHotelCard(hotel);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _buildCategoryBadge(String categoryName) {
    final isSelected = categoryName.toLowerCase() == selectedCategory.toLowerCase();

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = categoryName;
        });
      },
      child: Card(
        shadowColor: Colors.black54,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: isSelected ? Color(primaryColor) : Colors.grey[100],
            borderRadius: BorderRadius.circular(8.r),
            
          ),
          child: Row(
            children: [
              Icon(_getIconForCategory(categoryName), color: isSelected ? Colors.white : Colors.grey, size: 18.sp),
              SizedBox(width: 6.w),
              Text(
                categoryName,
                style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'hotel':
        return Icons.hotel;
      case 'villa':
        return Icons.villa;
      case 'apartment':
        return Icons.apartment;
      case 'homestay':
        return Icons.house;
      default:
        return Icons.place;
    }
  }


  Widget _buildHotelCard(HotelModel hotel) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, detailRoute,arguments: DetailArgument(img: hotel.img, name: hotel.name, price: hotel.price));
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Stack(
                children: [
                  Image.network(
                    hotel.img ?? '',
                    height: 200.h,
                    width: 160.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200.h,
                        width: 155.w,
                        color: Colors.grey[200],
                        child: Icon(Icons.broken_image, size: 50.sp),
                      );
                    },
                  ),
                  Positioned(
                    top: 5.w,
                    right: 5.h,
                    child: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Image.asset(icHomeFavoritOn,height: 20.h,width: 20.w)
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50.h,
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                      decoration: BoxDecoration(
                        color: Color(primaryColor).withOpacity(0.73),
                        borderRadius: BorderRadius.all(Radius.circular(12.r))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotel.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp)
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${hotel.price}/nigth",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10.sp),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "5.0 ",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10.sp),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Icon(Icons.star, color: Colors.yellow, size: 16.sp),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
