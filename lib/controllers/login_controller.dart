import 'package:reservasi_hotel_admin/core/routes/app_routes.dart';
import 'package:reservasi_hotel_admin/models/employee/login.dart';
import 'package:reservasi_hotel_admin/services/employee_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var employee = Rxn<Employee>();

  final EmployeeService _employeeService = EmployeeService();
  void login(String text, String text2) async {
    isLoading.value = true;
    try {
      final result = await _employeeService
          .login(UserLoginRequest(username: text, password: text2));
      isLoading.value = false;
      if (result != null) {
        employee.value = result;
        // Get.snackbar('Success', 'Login Successfully',
        //     snackPosition: SnackPosition.TOP,
        //     duration: const Duration(seconds: 2));
        // print('masuk result !=null');
        Get.offNamed(AppRouteRepo.home);
      } else {
        Get.snackbar('Error', 'Login Failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An Error occured while login');
    } finally {
      isLoading.value = false;
    }
  }

  static Future<void> checkToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jwtToken = pref.getString('token');
    if (jwtToken == null) {
      return;
    } else {
      Get.snackbar('Welcome back', 'Have a nice day!');
      Get.offNamed(AppRouteRepo.home);
    }
  }
}
