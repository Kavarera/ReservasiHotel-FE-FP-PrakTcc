class RoomModel {
  int length;
  List<RoomModelData> data;

  RoomModel({required this.length, required this.data});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    int length = json['length'];
    List<RoomModelData> data =
        (json['data'] as List).map((e) => RoomModelData.fromJson(e)).toList();
    return RoomModel(length: length, data: data);
  }

  Map<String, dynamic> toJson() => {"length": length, "data": data};
}

class RoomModelData {
  final int id;
  final String name;
  final String roomNumber;
  final int floor;
  final bool available;
  final int roomTypeId;

  RoomModelData(
      {required this.id,
      required this.name,
      required this.roomNumber,
      required this.floor,
      required this.available,
      required this.roomTypeId});

  factory RoomModelData.fromJson(Map<String, dynamic> json) {
    return RoomModelData(
        id: json['id'],
        name: json['name'],
        roomNumber: json['roomNumber'],
        floor: json['floor'],
        available: json['available'],
        roomTypeId: json['RoomTypeId']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'roomNumber': roomNumber,
        'floor': floor,
        'available': available,
        'RoomTypeId': roomTypeId
      };
}
