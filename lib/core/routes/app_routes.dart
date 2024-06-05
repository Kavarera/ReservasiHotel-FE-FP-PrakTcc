import 'package:reservasi_hotel_admin/views/pages/home_page.dart';
import 'package:reservasi_hotel_admin/views/pages/login_page.dart';
import 'package:reservasi_hotel_admin/views/pages/register_page.dart';
import 'package:reservasi_hotel_admin/views/pages/room_page.dart';
import 'package:reservasi_hotel_admin/views/pages/room_types_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppRouteRepo {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String roomTypes = '/roomtypes';
  static const String roomPageAdmin = '/roomsavailable';
  static List<GetPage<Widget>> pages = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: roomTypes, page: () => RoomTypesPage()),
    GetPage(name: roomPageAdmin, page: () => RoomPage()),
  ];
}
