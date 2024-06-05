import 'dart:convert';

import 'package:reservasi_hotel_admin/core/routes/api_routes.dart';
import 'package:reservasi_hotel_admin/models/employee/login.dart';
import 'package:reservasi_hotel_admin/models/employee/signup.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeService {
  Future<Employee?> login(UserLoginRequest userLoginRequest) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    final url = Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.login}');
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userLoginRequest.toJson()));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      pref.setString('token', data['token']);
      await Future.delayed(const Duration(seconds: 5));
      return Employee.fromJson(data['data']);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool?> register(EmployeeRegisterRequest err) async {
    final url = Uri.parse('${ApiRoutesRepo.baseUrl}${ApiRoutesRepo.register}');
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(err.toJson()));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to register');
    }
  }
}
