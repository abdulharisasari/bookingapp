import 'package:bookingapp/models/schedule_model.dart';
import 'package:flutter/material.dart';

class ScheduleProvider extends ChangeNotifier {
  Future<List<ScheduleModel>?> getSchedule()async{
    try {
      List<ScheduleModel> dummyHeader = [
        ScheduleModel(id: 1, name: "Gading Hotel", price: 1000, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045083/wht2mgxhltyrnipdsrqq.png", dateTime: "2023-10-01 12:00"),
        ScheduleModel(id: 2, name: "Sunset Inn", price: 1200, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045042/dtalumlpps1dsf8id2d6.png", dateTime: "2023-10-02 14:00"),
        ScheduleModel(id: 3, name: "Ocean View", price: 1500, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045046/jrdw9vpquuebh4bx42cd.png", dateTime: "2023-10-03 16:00"),
        ScheduleModel(id: 4, name: "Hilltop Stay", price: 1300, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045051/vxoiabdf4twgy0ykcdr9.png", dateTime: "2023-10-04 18:00"),
        ScheduleModel(id: 5, name: "City Center Hotel", price: 1700, img: "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716045083/wht2mgxhltyrnipdsrqq.png", dateTime: "2023-10-05 20:00"),
      ];
      return dummyHeader;
    } catch (e) {
      debugPrint("catch getSchedule --$e");
    }
    return null;
  }

  
}