import 'dart:convert';

import 'package:fe_sendiri_prak_tcc_fp/core/routes/api_routes.dart';
import 'package:fe_sendiri_prak_tcc_fp/models/booking/booking_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingService {
  Future<BookingPublicModel?> getPublicBookingData(
      {bool isPrivate = false}) async {
    final url = Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.bookings}');
    // Future.delayed(const Duration(seconds: 55));

    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jwtToken = pref.getString('token');
    if (jwtToken == null) {
      throw Exception('No token found');
    }

    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        if (isPrivate == true) 'Authorization': 'Bearer $jwtToken',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return BookingPublicModel.fromJson(data);
    } else {
      throw Exception('Failed to get booking data: ${response.statusCode}');
    }
  }

  Future<BookingPrivateModel?> getPrivateBookingData() async {
    final url =
        Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.adminBookings}');
    // Future.delayed(const Duration(seconds: 55));

    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jwtToken = pref.getString('token');
    if (jwtToken == null) {
      throw Exception('No token found');
    }

    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtToken',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return BookingPrivateModel.fromJson(data);
    } else {
      throw Exception('Failed to get booking data: ${response.statusCode}');
    }
  }
}
