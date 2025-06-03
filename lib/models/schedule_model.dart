class ScheduleModel {
  int? id, price;
  String? name, img, dateTime;

  ScheduleModel({this.id, this.name, this.price, this.img, this.dateTime});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(id: json['id'], price: json['price'], name: json['name'], img: json['img'], dateTime: json['date_time']);
  }

  static List<ScheduleModel> fromList(List<dynamic> list) {
    return list.map((e) => ScheduleModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'img': img,
        'date_time':dateTime
      };
}
