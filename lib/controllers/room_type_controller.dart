import 'dart:typed_data';

import 'package:reservasi_hotel_admin/models/roomtype/room_type_model.dart';
import 'package:reservasi_hotel_admin/services/room_type_service.dart';
import 'package:get/get.dart';

class RoomTypeController extends GetxController {
  var roomTypes = Rxn<RoomType>();
  var selectedRoomTypes = Rxn<RoomTypeData>();
  var isLoading = false.obs;
  var imageUrl = ''.obs;
  RoomTypeService rts = RoomTypeService();

  void setSelectedRoomTypes(RoomTypeData rt) {
    selectedRoomTypes.value = rt;
  }

  void _getRoomTypes() async {
    try {
      isLoading.value = true;
      final result = await rts.getRoomType();
      roomTypes.value = result;
      isLoading.value = false;
      selectedRoomTypes.value = result.data.first;
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  Future<void> _postNewRoomType(RoomTypeInserRequest rtir) async {
    try {
      await rts.insertRoomType(rtir);
      _getRoomTypes();
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

  Future<void> deleteRoomType(RoomTypeData rt) async {
    try {
      await rts.deleteRoomType(rt.id);
      Get.snackbar('Success', 'Removing done');
      _getRoomTypes();
    } catch (e) {
      Get.snackbar('Failed', e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getRoomTypes();
  }

  Future<void> updatePriceRoomType(RoomTypeData elementAt, String text) async {
    elementAt.price = text;
    try {
      await rts.updatePriceRoomType(elementAt);
      Get.snackbar('Success', 'Update Succesfully');
      _getRoomTypes();
    } catch (e) {
      Get.snackbar('Failed', e.toString());
    }
  }
}
