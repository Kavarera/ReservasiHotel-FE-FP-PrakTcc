import 'dart:convert';

import 'package:fe_sendiri_prak_tcc_fp/core/routes/api_routes.dart';
import 'package:fe_sendiri_prak_tcc_fp/models/room/room_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> insertRoom(RoomModel room) async {
    final url =
        Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.insertRoom}');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jwtToken = pref.getString('token');
    if (jwtToken == null) {
      throw Exception('No token found');
    }

    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(room.toJson()));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      RoomModel.fromJson(data);
      return true;
    } else {
      throw Exception('Failed to add new room: ${response.statusCode}');
    }
  }
}
