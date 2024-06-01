import 'dart:convert';
import 'dart:typed_data';

import 'package:fe_sendiri_prak_tcc_fp/core/routes/api_routes.dart';
import 'package:fe_sendiri_prak_tcc_fp/models/roomtype/room_type_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomTypeService {
  Future<RoomType> getRoomType() async {
    final url = Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.roomTypes}');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return RoomType.fromJson(data);
    } else {
      throw Exception('Failed to get booking data: ${response.statusCode}');
    }
  }

  Future<String> uploadImage(String? imageName, Uint8List? imageBytes) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token == null) {
      throw Exception('No token');
    }
    if (imageName == null || imageBytes == null) {
      throw Exception('No Image Selected');
    }
    final url =
        Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.uploadImage}');
    var request = http.MultipartRequest(
      'POST',
      url,
    );
    request.headers['Authorization'] = 'Bearer $token';

    final mimeType = lookupMimeType(imageName, headerBytes: imageBytes);
    final mediaType = mimeType != null
        ? MediaType.parse(mimeType)
        : MediaType('image', 'png');

    request.files.add(http.MultipartFile.fromBytes('file', imageBytes,
        filename: imageName, contentType: mediaType));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final result = jsonDecode(String.fromCharCodes(responseData));
      return result['url'];
    } else {
      throw Exception('Failed upload image');
    }
  }

  Future<void> insertRoomType(RoomTypeInserRequest rt) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token == null) {
      throw Exception('No token');
    }
    final url =
        Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.insertRoomType}');

    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(rt.toJson()));

    if (response.statusCode == 201) {
      Get.snackbar('Success', 'New Room Type Added');
    } else {
      throw Exception(
          'Failed to add a Room Type, statusCode = ${response.statusCode}');
    }
  }
}
