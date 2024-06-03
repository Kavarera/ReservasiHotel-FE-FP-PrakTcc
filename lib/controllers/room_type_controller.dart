import 'dart:typed_data';

import 'package:fe_sendiri_prak_tcc_fp/models/roomtype/room_type_model.dart';
import 'package:fe_sendiri_prak_tcc_fp/services/room_type_service.dart';
import 'package:get/get.dart';

class RoomTypeController extends GetxController {
  var roomTypes = Rxn<RoomType>();
  var isLoading = false.obs;
  var imageUrl = ''.obs;
  RoomTypeService rts = RoomTypeService();
  void _getRoomTypes() async {
    try {
      isLoading.value = true;
      final result = await rts.getRoomType();
      roomTypes.value = result;
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  Future<void> _postNewRoomType(RoomTypeInserRequest rtir) async {
    try {
      await rts.insertRoomType(rtir);
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  Future<void> uploadImage(String roomtypeName, double roomTypePrice,
      String imageName, Uint8List? imageBytes) async {
    if (imageBytes == null) {
      Get.snackbar('Error', 'Imagebytes is null');
    }
    try {
      imageUrl.value = await rts.uploadImage(imageName, imageBytes);
      await _postNewRoomType(RoomTypeInserRequest(
          name: roomtypeName,
          price: roomTypePrice.toDouble(),
          imageUrl: imageUrl.value));
      Get.snackbar('done', 'Image uploaded');
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  Future<void> updateRoomType() async {
    isLoading.value = true;
    _getRoomTypes();
  }

  @override
  void onInit() {
    super.onInit();
    _getRoomTypes();
  }
}