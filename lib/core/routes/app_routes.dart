import 'package:fe_sendiri_prak_tcc_fp/views/pages/home_page.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/pages/login_page.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppRouteRepo {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static List<GetPage<Widget>> pages = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: register, page: () => RegisterPage()),
  ];
}
