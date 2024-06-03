import 'dart:convert';

import 'package:fe_sendiri_prak_tcc_fp/core/routes/api_routes.dart';
import 'package:fe_sendiri_prak_tcc_fp/models/room/room_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RoomService {
  Future<RoomModel?> getRoomModel() async {
    final url = Uri.parse(ApiRoutesRepo.baseUrl + ApiRoutesRepo.roomAvailable);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token == null) {
      throw Exception('No token');
    }
    final http.Response response =
        await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return RoomModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch room model ${response.statusCode}');
    }
  }

  Future<bool> insertRoom(RoomModelData room) async {
    final url =
        Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.insertDeleteRoom}');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jwtToken = pref.getString('token');
    if (jwtToken == null) {
      throw Exception('No token found');
    }

    print(room.toJson());

    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(room.toJson()));
    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      RoomModel.fromJson(data);
      return true;
    } else {
      throw Exception('Failed to add new room: ${response.statusCode}');
    }
  }

  Future<bool> deleteRoom(int id) async {
    final url =
        Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.insertDeleteRoom}');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jwtToken = pref.getString('token');
    if (jwtToken == null) {
      throw Exception('No token found');
    }
    final http.Response response = await http.delete(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode({"id": id}));
    print(response.body);
    if (response.statusCode == 200) {
      print('berhasil');
      final Map<String, dynamic> data = json.decode(response.body);
      print('berhasil');
      return true;
    } else {
      print('ini ngapa ya?? ${response.statusCode}');
      throw Exception('Failed to delete room: ${response.statusCode}');
    }
  }
}
