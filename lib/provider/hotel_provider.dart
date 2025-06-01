import 'package:bookingapp/models/hotel_model.dart';
import 'package:flutter/material.dart';

class HotelProvider extends ChangeNotifier {
 Future<List<HotelModel>?> getHotel() async{
  try {
    List<HotelModel> dummyHeader = [
        HotelModel(id: 1, name: "Gading Hotel", price: 1000, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045083/wht2mgxhltyrnipdsrqq.png", categoryId: 1, categoryName: "Hotel"),
        HotelModel(id: 2, name: "Sunset Inn", price: 1200, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045042/dtalumlpps1dsf8id2d6.png", categoryId: 2, categoryName: "Homestay"),
        HotelModel(id: 3, name: "Ocean View", price: 1500, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045046/jrdw9vpquuebh4bx42cd.png", categoryId: 3, categoryName: "Apartemen"),
        HotelModel(id: 4, name: "Hilltop Stay", price: 1300, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045051/vxoiabdf4twgy0ykcdr9.png", categoryId: 4, categoryName: "Villa"),
        HotelModel(id: 5, name: "City Center Hotel", price: 1700, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045083/wht2mgxhltyrnipdsrqq.png", categoryId: 1, categoryName: "Hotel"),
        HotelModel(id: 6, name: "Mountain Lodge", price: 900, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045042/dtalumlpps1dsf8id2d6.png", categoryId: 2, categoryName: "Homestay"),
        HotelModel(id: 7, name: "Riverside Inn", price: 1100, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045046/jrdw9vpquuebh4bx42cd.png", categoryId: 3, categoryName: "Apartemen"),
        HotelModel(id: 8, name: "Palm Resort", price: 1600, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045051/vxoiabdf4twgy0ykcdr9.png", categoryId: 4, categoryName: "Villa"),
        HotelModel(id: 9, name: "Tropical Stay", price: 1400, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045083/wht2mgxhltyrnipdsrqq.png", categoryId: 1, categoryName: "Hotel"),
        HotelModel(id: 10, name: "Urban Nest", price: 1250, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045042/dtalumlpps1dsf8id2d6.png", categoryId: 2, categoryName: "Homestay"),
        HotelModel(id: 11, name: "Skyline Suites", price: 2100, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045046/jrdw9vpquuebh4bx42cd.png", categoryId: 3, categoryName: "Apartemen"),
        HotelModel(id: 12, name: "Cozy Inn", price: 950, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045051/vxoiabdf4twgy0ykcdr9.png", categoryId: 4, categoryName: "Villa"),
        HotelModel(id: 13, name: "Harbor Hotel", price: 1750, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045083/wht2mgxhltyrnipdsrqq.png", categoryId: 1, categoryName: "Hotel"),
        HotelModel(id: 14, name: "Greenland Stay", price: 1150, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045042/dtalumlpps1dsf8id2d6.png", categoryId: 2, categoryName: "Homestay"),
        HotelModel(id: 15, name: "Lakeview Inn", price: 1050, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045046/jrdw9vpquuebh4bx42cd.png", categoryId: 3, categoryName: "Apartemen"),
        HotelModel(id: 16, name: "Vintage Hotel", price: 1450, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045051/vxoiabdf4twgy0ykcdr9.png", categoryId: 4, categoryName: "Villa"),
      ];

    return dummyHeader;
  } catch (e) {
    debugPrint("catch getHotel --$e");
  }
  return null;
 }
}
