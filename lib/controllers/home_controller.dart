import 'package:fe_sendiri_prak_tcc_fp/models/booking/booking_public_model.dart';
import 'package:fe_sendiri_prak_tcc_fp/services/booking_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var totalEmployee = 0.obs;
  var totalProfit = 0.obs;
  var bookings = Rxn<BookingPublicModel>();
  var isLoading = false.obs;

  //singleton
  static HomeController get instance =>
      Get.find<HomeController>(tag: 'homeController');

  void _getPrivateBookingData() async {
    isLoading.value = true;
    try {
      BookingService bs = BookingService();
      final result = await bs.getPublicBookingData();
      // await Future.delayed(const Duration(seconds: 10));
      bookings.value = result;
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getPrivateBookingData();
    isLoading.value = true;
  }
}
