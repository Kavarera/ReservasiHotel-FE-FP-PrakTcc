import 'package:cached_network_image/cached_network_image.dart';
import 'package:reservasi_hotel_admin/controllers/navigation_controller.dart';
import 'package:reservasi_hotel_admin/controllers/room_page_controller.dart';
import 'package:reservasi_hotel_admin/controllers/room_type_controller.dart';
import 'package:reservasi_hotel_admin/models/room/room_model.dart';
import 'package:reservasi_hotel_admin/models/roomtype/room_type_model.dart';
import 'package:reservasi_hotel_admin/views/widgets/custom_app_bar.dart';
import 'package:reservasi_hotel_admin/views/widgets/loading_full_page_widget.dart';
import 'package:reservasi_hotel_admin/views/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return SafeArea(
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
          body: Obx(() {
            return controller.isLoading.value == true
                ? Center(
                    child:
                        LoadingFullpage(isLoading: controller.isLoading.value))
                : controller.rooms.value != null
                    ? ListView.builder(
                        itemCount: controller.rooms.value!.length,
                        itemBuilder: ((context, index) {
                          return MediaQuery.of(context).size.width <= 800
                              ? Center(child: Text('Screen Too Small'))
                              : Card(
                                  surfaceTintColor: Colors.white,
                                  shadowColor: Colors.black,
                                  elevation: 40,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Container(
                                    height: 300,
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 300,
                                          child: CachedNetworkImage(
                                            imageUrl: controller
                                                .getRoomTypeById(index)
                                                .imageUrl,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller.rooms.value!.data
                                                    .elementAt(index)
                                                    .name,
                                                style: GoogleFonts.firaSans(
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                              Text(
                                                controller
                                                    .getRoomTypeById(index)
                                                    .name,
                                                style: GoogleFonts.firaSans(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                              Text(
                                                "Floor : ${controller.rooms.value!.data.elementAt(index).floor}",
                                                style: GoogleFonts.firaSans(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                              Text(
                                                "Price IDR : ${controller.getRoomTypeById(index).price}",
                                                style: GoogleFonts.firaSans(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            print(
                                                'clicked ${controller.rooms.value!.data.elementAt(index).id}');
                                            _deleteRoom(controller
                                                .rooms.value!.data
                                                .elementAt(index));
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                          ),
                                          child: Text(
                                            'Hapus',
                                            style: GoogleFonts.firaSans(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        }))
                    : const Center(
                        child: Text('No Data'),
                      );
          })),
    );
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
                await controller.postRoom(RoomModelData(
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

  void _deleteRoom(RoomModelData rm) async {
    await controller.deleteRoom(rm);
  }
}
