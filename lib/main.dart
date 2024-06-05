import 'package:reservasi_hotel_admin/controllers/navigation_controller.dart';
import 'package:reservasi_hotel_admin/controllers/room_type_controller.dart';
import 'package:reservasi_hotel_admin/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(NavigationController());
      }),
      getPages: AppRouteRepo.pages,
      initialRoute: AppRouteRepo.login,
    );
  }
}
