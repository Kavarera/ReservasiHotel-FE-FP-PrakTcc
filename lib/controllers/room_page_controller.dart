import 'package:fe_sendiri_prak_tcc_fp/core/routes/app_routes.dart';
import 'package:fe_sendiri_prak_tcc_fp/models/room/room_model.dart';
import 'package:fe_sendiri_prak_tcc_fp/models/roomtype/room_type_model.dart';
import 'package:fe_sendiri_prak_tcc_fp/services/room_service.dart';
import 'package:fe_sendiri_prak_tcc_fp/services/room_type_service.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  var isLoading = false.obs;
  var rooms = Rxn<RoomModel>();
  var roomType = Rxn<RoomType>();
  Future<void> getRoomData() async {
    await _fetchRoomId();
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

  Future<void> _fetchRoomId() async {
    isLoading.value = true;
    try {
      RoomTypeService rts = RoomTypeService();
      final result = await rts.getRoomType();
      roomType.value = result;
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  Future<void> postRoomType(RoomModelData rm) async {
    try {
      RoomService roomService = RoomService();
      print('awal post');
      bool result = await roomService.insertRoom(rm);
      if (result == true) {
        print('selesai post');
        Get.snackbar('Success', 'Success add new room');
      } else {
        Get.snackbar('Failed', 'Failed add new room');
      }
    } catch (e) {
      print('$e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getRoomData();
    isLoading.value = true;
  }

  void updateRoom() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 5));
    await getRoomData();
    isLoading.value = false;
  }
}
