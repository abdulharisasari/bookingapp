class HotelModel {
  int? id, price, categoryId;
  String? name, img, categoryName;

  HotelModel({this.id,this.name,this.price, this.img, this.categoryId,this.categoryName});

  factory HotelModel.fromJson(Map<String,dynamic> json){
    return HotelModel(
      id: json['id'],
      price: json['price'],
      name: json['name'],
      img: json['img'],
      categoryId: json['category_id'],
      categoryName: json['category_name']
    );
  }

  static List<HotelModel>fromList(List<dynamic> list){
    return list.map((e) => HotelModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'name': name,
    'price': price,
    'img': img,
    'category_id': categoryId,
    'category_name': categoryName
  };
}