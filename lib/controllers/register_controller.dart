import 'package:reservasi_hotel_admin/core/routes/app_routes.dart';
import 'package:reservasi_hotel_admin/models/employee/signup.dart';
import 'package:reservasi_hotel_admin/services/employee_service.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  final EmployeeService _es = EmployeeService();
  void register(String text, String text2, String text3) async {
    isLoading.value = true;
    try {
      final result = await _es.register(EmployeeRegisterRequest(
          username: text, fullName: text2, password: text3, roleId: 1));
      print('after post awiat ${result}');
      if (result == true) {
        Get.snackbar('Success', 'Register Successfully',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2));
        Get.offNamed(AppRouteRepo.login);
      } else {
        Get.snackbar('Error', 'Register Failed');
      }
    } catch (e) {
      print('masuk catch controler ${e}');
      Get.snackbar('Error', 'An Error occured while login');
    } finally {
      isLoading.value = false;
    }
  }
}
