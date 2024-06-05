import 'package:reservasi_hotel_admin/core/routes/app_routes.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.offNamed(AppRouteRepo.home);
        break;
      case 1:
        Get.offNamed(AppRouteRepo.roomTypes);
        break;
      case 2:
        Get.offNamed(AppRouteRepo.roomPageAdmin);
        break;
      // Tambahkan navigasi lain sesuai kebutuhan
    }
  }
}
