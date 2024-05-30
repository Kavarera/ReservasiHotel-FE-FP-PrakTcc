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
