import 'package:fe_sendiri_prak_tcc_fp/controllers/room_type_controller.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/custom_app_bar.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/loading_full_page_widget.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/navigation_drawer_widget.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/room_type_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class RoomTypesPage extends StatefulWidget {
  @override
  RoomTypesPage({super.key});

  @override
  State<RoomTypesPage> createState() => _RoomTypesPageState();
}

class _RoomTypesPageState extends State<RoomTypesPage> {
  final controller = Get.put(RoomTypeController());
  dynamic result;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppbar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _showAddRoomDialog(context);
            await controller.updateRoomType();
            // Navigator.of(context).pop();
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        drawer: CustomNavigationDrawer(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: LoadingFullpage(isLoading: true),
            );
          } else {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                      MediaQuery.of(context).size.width > 1300 ? 300 : 400,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.roomTypes.value!.data.length,
                itemBuilder: (context, index) {
                  return RoomTypeCard(
                      roomType:
                          controller.roomTypes.value!.data.elementAt(index));
                });
          }
        }),
      ),
    );
  }

  Future<void> _showAddRoomDialog(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          elevation: 30,
          title: const Text('Add Room Type'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(labelText: 'Room Type Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) < 0) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  decoration:
                      const InputDecoration(labelText: 'Room Type Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (kIsWeb) {
                      await _pickImage(nameController.text,
                          double.parse(priceController.text));
                    } else {
                      Get.snackbar('Eror', 'Feature not available');
                    }
                  },
                  child: const Text('Select Image'),
                ),
              ],
            ),
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
                await controller.uploadImage(
                    nameController.text,
                    double.parse(priceController.text),
                    result!.files.single.name,
                    result.files.single.bytes);
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(String name, double price) async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
  }
}
