import 'package:fe_sendiri_prak_tcc_fp/models/booking/booking_model.dart';
import 'package:fe_sendiri_prak_tcc_fp/services/booking_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var totalEmployee = 0.obs;
  var totalProfit = 0.obs;
  var bookings = Rxn<BookingPrivateModel>();
  var isLoading = false.obs;
  var currentPage = 1.obs;

  //singleton
  static HomeController get instance =>
      Get.find<HomeController>(tag: 'homeController');

  void changeNavigation(int value) {
    currentPage.value = value;
  }

  void _getPrivateBookingData() async {
    isLoading.value = true;
    try {
      BookingService bs = BookingService();
      final result = await bs.getPrivateBookingData();
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
