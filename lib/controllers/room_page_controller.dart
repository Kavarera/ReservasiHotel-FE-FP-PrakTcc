import 'package:fe_sendiri_prak_tcc_fp/models/room/room_model.dart';
import 'package:fe_sendiri_prak_tcc_fp/services/room_service.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  var isLoading = false.obs;
  var rooms = Rxn<RoomModel>();
  void getRoomData() async {
    isLoading.value = true;
    try {
      RoomService rs = RoomService();
      final result = await rs.getRoomModel();
      // await Future.delayed(const Duration(seconds: 10));
      rooms.value = result;
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getRoomData();
    isLoading.value = true;
  }
}
