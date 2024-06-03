import 'dart:convert';

import 'package:fe_sendiri_prak_tcc_fp/core/routes/api_routes.dart';
import 'package:fe_sendiri_prak_tcc_fp/models/room/room_model.dart';
import 'package:http/http.dart' as http;

class RoomService {
  Future<RoomModel?> getRoomModel() async {
    final url = Uri.parse(ApiRoutesRepo.baseUrl + ApiRoutesRepo.roomAvailable);

    final http.Response response = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      return RoomModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch room model');
    }
  }
}
