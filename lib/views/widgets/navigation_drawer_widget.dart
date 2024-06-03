import 'package:fe_sendiri_prak_tcc_fp/controllers/navigation_controller.dart';
import 'package:fe_sendiri_prak_tcc_fp/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNavigationDrawer extends StatelessWidget {
  final NavigationController navigationController = Get.find();
  CustomNavigationDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          DrawerHeader(
              child: Center(
            child: Text(
              'Tinggal-in',
              style: GoogleFonts.firaSans(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
          )),
          ListTile(
            title: const Text(
              'Bookings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              navigationController.changePage(0);
            },
          ),
          ListTile(
            title: const Text(
              'Room Types',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              print('change to 1');
              navigationController.changePage(1);
            },
          ),
          ListTile(
            title: const Text(
              'Rooms',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              navigationController.changePage(2);
            },
          ),
          ListTile(
            title: const Text(
              'Employees',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mode Malam',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Switch(value: false, onChanged: (v) {})
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              'About Dev',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
