import 'package:fe_sendiri_prak_tcc_fp/controllers/navigation_controller.dart';
import 'package:fe_sendiri_prak_tcc_fp/controllers/room_page_controller.dart';
import 'package:fe_sendiri_prak_tcc_fp/controllers/room_type_controller.dart';
import 'package:fe_sendiri_prak_tcc_fp/models/room/room_model.dart';
import 'package:fe_sendiri_prak_tcc_fp/models/roomtype/room_type_model.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/custom_app_bar.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/loading_full_page_widget.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final RoomController controller = Get.put(RoomController());
  final GlobalKey _menuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value == true
          ? LoadingFullpage(isLoading: controller.isLoading.value)
          : SafeArea(
              child: Scaffold(
                appBar: const CustomAppbar(),
                drawer: CustomNavigationDrawer(),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    await _showAddRoomDialog(context);
                    controller.updateRoom();
                    // Navigator.of(context).pop();
                  },
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                body: controller.rooms.value != null
                    ? ListView.builder(
                        itemCount: controller.rooms.value!.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            title: Text(
                                '${controller.rooms.value!.data.elementAt(index).name} - ${controller.rooms.value!.data.elementAt(index).roomTypeId}'),
                          );
                        }))
                    : const Center(
                        child: Text('No Data'),
                      ),
              ),
            );
    });
  }

  Future<void> _showAddRoomDialog(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController roomNumberController = TextEditingController();
    TextEditingController floorController = TextEditingController();

    final RoomTypeController rtController = Get.put(RoomTypeController());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          elevation: 30,
          title: const Text('Add New Room'),
          content: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Room Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: roomNumberController,
                decoration: const InputDecoration(labelText: 'Room Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Room Number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: floorController,
                decoration: const InputDecoration(labelText: 'Room Floor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Room Floor';
                  }
                  return null;
                },
              ),
              Obx(
                () => DropdownButton<RoomTypeData>(
                  value: rtController.selectedRoomTypes.value,
                  items: rtController.roomTypes.value?.data
                          .map((RoomTypeData roomType) {
                        return DropdownMenuItem<RoomTypeData>(
                          value: roomType,
                          child: Text(roomType.name),
                        );
                      }).toList() ??
                      [],
                  onChanged: (RoomTypeData? e) {
                    if (e != null) {
                      rtController.setSelectedRoomTypes(e);
                    }
                  },
                ),
              )
            ]),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                await controller.postRoomType(RoomModelData(
                    id: 0,
                    name: nameController.text,
                    roomNumber: roomNumberController.text,
                    floor: int.parse(floorController.text),
                    available: true,
                    roomTypeId: rtController.selectedRoomTypes.value!.id));
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
