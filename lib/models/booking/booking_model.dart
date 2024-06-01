class BookingPublicModel {
  int length;
  List<Data> data;

  BookingPublicModel({required this.length, required this.data});

  factory BookingPublicModel.fromJson(Map<String, dynamic> json) {
    List<Data> dataList =
        (json['data'] as List).map((e) => Data.fromJson(e)).toList();
    return BookingPublicModel(length: json['length'], data: dataList);
  }

  Map<String, dynamic> toJson() => {'length': length, 'data': Data};
}

class Data {
  String checkin;
  int days;

  Data({required this.checkin, required this.days});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(checkin: json["checkin"], days: json["days"]);

  Map<String, dynamic> toJson() => {'checkin': checkin, 'days': days};
}

class BookingPrivateModel {
  int length;
  List<Dataprivate?> dataprivate;

  BookingPrivateModel({required this.length, required this.dataprivate});

  factory BookingPrivateModel.fromJson(Map<String, dynamic> json) {
    int length = json['length'];
    List<Dataprivate?>? dataprivate =
        (json["data"] as List?)?.map((e) => Dataprivate.fromJson(e)).toList();

    return BookingPrivateModel(length: length, dataprivate: dataprivate ?? []);
  }

  Map<String, dynamic> toJson() =>
      {'length': length, 'data': dataprivate.map((v) => v?.toJson()).toList()};
}

class Dataprivate {
  String kodeBooking;
  String checkin;
  int days;
  int roomId;
  int customerId;

  Dataprivate(
      {required this.kodeBooking,
      required this.checkin,
      required this.days,
      required this.roomId,
      required this.customerId});

  factory Dataprivate.fromJson(Map<String, dynamic> json) {
    return Dataprivate(
      kodeBooking: json['kode_booking'] ?? '',
      checkin: json['checkin'] ?? '',
      days: json['days'] ?? 0,
      roomId: json['RoomId'] ?? 0,
      customerId: json['CustomerId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "kodeBooking": kodeBooking,
        "checkin": checkin,
        "days": days,
        "roomId": roomId,
        "customerId": customerId
      };
}
