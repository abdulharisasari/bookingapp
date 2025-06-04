import 'package:bookingapp/services/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

import '../../common/app_bar.dart';
import '../../services/themes.dart';

class LocationPage extends StatefulWidget {
   LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late GoogleMapController mapController;
  late BitmapDescriptor customIcon;
  String selectedCategory = 'Hotel';
  final List<Map<String, dynamic>> staticLocations = [
    {
      "id": "gading_hotel",
      "position": LatLng(-6.1700, 106.8970),
      "title": "Gading Hotel",
    },
    {
      "id": "sunset_inn",
      "position": LatLng(-6.1760, 106.9025),
      "title": "Sunset Inn",
    },
    {
      "id": "ocean_view",
      "position": LatLng(-6.1685, 106.9050),
      "title": "Ocean View",
    },
    {
      "id": "hilltop_stay",
      "position": LatLng(-6.1790, 106.8987),
      "title": "Hilltop Stay",
    },
    {
      "id": "city_center_hotel",
      "position": LatLng(-6.1720, 106.9120),
      "title": "City Center Hotel",
    },
    {
      "id": "mountain_lodge",
      "position": LatLng(-6.1660, 106.8990),
      "title": "Mountain Lodge",
    },
    {
      "id": "riverside_inn",
      "position": LatLng(-6.1755, 106.8930),
      "title": "Riverside Inn",
    },
    {
      "id": "palm_resort",
      "position": LatLng(-6.1692, 106.9033),
      "title": "Palm Resort",
    },
    {
      "id": "tropical_stay",
      "position": LatLng(-6.1777, 106.9067),
      "title": "Tropical Stay",
    },
    {
      "id": "urban_nest",
      "position": LatLng(-6.1745, 106.9105),
      "title": "Urban Nest",
    },
    {
      "id": "skyline_suites",
      "position": LatLng(-6.1718, 106.8952),
      "title": "Skyline Suites",
    },
    {
      "id": "cozy_inn",
      "position": LatLng(-6.1783, 106.9005),
      "title": "Cozy Inn",
    },
    {
      "id": "harbor_hotel",
      "position": LatLng(-6.1677, 106.9070),
      "title": "Harbor Hotel",
    },
    {
      "id": "greenland_stay",
      "position": LatLng(-6.1732, 106.8927),
      "title": "Greenland Stay",
    },
    {
      "id": "lakeview_inn",
      "position": LatLng(-6.1699, 106.9008),
      "title": "Lakeview Inn",
    },
    {
      "id": "vintage_hotel",
      "position": LatLng(-6.1750, 106.8975),
      "title": "Vintage Hotel",
    },
  ];

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _loadIconAndMarkers();
  }

  Future<void> _loadIconAndMarkers() async {
    customIcon = await BitmapDescriptor.fromAssetImage( ImageConfiguration(size: Size(64, 64)), icLocationPinMap);
    _addMarkers();
  }

  void _addMarkers() {
    markers = staticLocations.map((loc) {
      return Marker(
        markerId: MarkerId(loc["id"]),
        position: loc["position"],
        icon: customIcon,
        infoWindow: InfoWindow(title: loc["title"]),
        onTap: () => _drawRouteTo(loc["position"]),
      );
    }).toSet();
    setState(() {});
  }

  Future<void> _drawRouteTo(LatLng destination) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position currentPosition = await Geolocator.getCurrentPosition();
    LatLng origin = LatLng(currentPosition.latitude, currentPosition.longitude);

    final polylinePoints = PolylinePoints();
    final result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCz2lLwBT3d-8TpoTl8Um32PSZitcoxNhc',
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      final List<LatLng> polylineCoords = result.points.map((p) => LatLng(p.latitude, p.longitude)).toList();

      setState(() {
        polylines.clear();
        polylines.add(Polyline(
          polylineId: PolylineId('route'),
          color: Colors.brown,
          width: 6,
          points: polylineCoords,
        ));
      });

      mapController.animateCamera(CameraUpdate.newLatLngBounds(_getBounds(origin, destination), 70));
    }
  }

  LatLngBounds _getBounds(LatLng start, LatLng end) {
    return LatLngBounds(
      southwest: LatLng(
        start.latitude < end.latitude ? start.latitude : end.latitude,
        start.longitude < end.longitude ? start.longitude : end.longitude,
      ),
      northeast: LatLng(
        start.latitude > end.latitude ? start.latitude : end.latitude,
        start.longitude > end.longitude ? start.longitude : end.longitude,
      ),
    );
  }

  final CameraPosition initialCameraPosition =  CameraPosition(
    target: LatLng(-6.1555, 106.9175),
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (controller) => mapController = controller,
            markers: markers,
            polylines: polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          buildCircleIconButton(
            bottom: 140.sp,
            right: 15.sp,
            icon: Icons.my_location,
            iconSize: 20.sp,
            onPressed: () async{
             final position = await Geolocator.getCurrentPosition();
              mapController.animateCamera(CameraUpdate.newLatLng(
              LatLng(position.latitude, position.longitude),
              ));
            },
          ),
          buildCircleIconButton(
            bottom: 80.sp,
            right: 15.sp,
            icon: Icons.zoom_in,
            iconSize: 20.sp,
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomIn());
            },
          ),
          buildCircleIconButton(
            bottom: 20.sp,
            right: 15.sp,
            icon: Icons.zoom_out,
            iconSize: 20.sp,
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomOut());
            },
          ),
          Positioned(
            top: 30,
            left: 15,
            right: 15,
            child: AppBarBooking(title: " Location ", icon: icLocationFilter, onPressed: () {})
          ),

          Positioned(
            top: 100,
            left: 15,
            right: 15,
            child: SizedBox(
              height: 54,
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
          ),
        ],
      ),
    );
  }

  Positioned buildCircleIconButton({required double bottom, required double right, required IconData icon, required VoidCallback onPressed, double size = 50, double iconSize = 20, Color backgroundColor = const Color.fromARGB(230, 255, 255, 255), Color iconColor = Colors.grey}) {
    return Positioned(
      bottom: bottom,
      right: right,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: iconSize, color: iconColor),
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
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(color: isSelected ? Color(primaryColor) : Colors.grey[100], borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Icon(_getIconForCategory(categoryName), color: isSelected ? Colors.white : Colors.grey, size: 18),
              SizedBox(width: 6),
              Text(categoryName, style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontWeight: FontWeight.w500)),
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
}
