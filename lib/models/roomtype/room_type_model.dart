class RoomType {
  int length;
  List<RoomTypeData> data;

  RoomType({required this.length, required this.data});

  factory RoomType.fromJson(Map<String, dynamic> json) {
    int length = json['length'];
    List<RoomTypeData> data =
        (json['data'] as List).map((e) => RoomTypeData.fromJson(e)).toList();
    return RoomType(length: length, data: data);
  }

  Map<String, dynamic> toJson() =>
      {'length': length, 'data': data.map((e) => e.toJson())};
}

class RoomTypeData {
  int id;
  String name;
  String price;
  String imageUrl;

  RoomTypeData(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl});

  factory RoomTypeData.fromJson(Map<String, dynamic> json) {
    return RoomTypeData(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
      };
}

class RoomTypeInserRequest {
  String name;
  double price;
  String imageUrl;

  RoomTypeInserRequest(
      {required this.name, required this.price, required this.imageUrl});

  factory RoomTypeInserRequest.fromJson(Map<String, dynamic> json) {
    return RoomTypeInserRequest(
        name: json['name'], price: json['price'], imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'price': price, 'imageUrl': imageUrl};
}
