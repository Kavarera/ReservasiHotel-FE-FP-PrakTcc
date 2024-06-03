import 'package:fe_sendiri_prak_tcc_fp/controllers/room_page_controller.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/custom_app_bar.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final GlobalKey _menuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final RoomController controller = Get.put(RoomController());
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(),
        drawer: CustomNavigationDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _showAddRoomDialog(context);
            await controller.updateRoom();
            // Navigator.of(context).pop();
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _showAddRoomDialog(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController roomNumberController = TextEditingController();
    TextEditingController floorController = TextEditingController();
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
            ]),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
