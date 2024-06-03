import 'package:fe_sendiri_prak_tcc_fp/controllers/home_controller.dart';
import 'package:fe_sendiri_prak_tcc_fp/controllers/navigation_controller.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/custom_app_bar.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/loading_full_page_widget.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/report_stat_widget.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/table_booking_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fe_sendiri_prak_tcc_fp/views/widgets/navigation_drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _menuKey = GlobalKey();
  final HomeController _homeController =
      Get.put(HomeController(), tag: 'homeController', permanent: true);

  final NavigationController _navigationController = Get.find();

  void _showPopupMenu() {
    final RenderBox button =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu<String>(
            context: context,
            position: position,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.black,
            elevation: 15,
            popUpAnimationStyle:
                AnimationStyle(duration: const Duration(milliseconds: 300)),
            constraints: const BoxConstraints(maxHeight: 300, maxWidth: 350),
            items: [
              'Pelanggan 1',
              'Pelanggan 2',
              'Pelanggan 3',
              'Pelanggan 4',
              'Pelanggan 5',
            ].map((String value) {
              return PopupMenuItem<String>(
                value: value,
                child: Container(
                  width: 300, // Atur lebar item menu
                  height: 80, // Atur tinggi item menu
                  alignment: Alignment.center,
                  child: ListTile(
                    title: Text(value),
                    leading: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList())
        .then((value) {
      if (value != null) {
        // Handle menu item selection
        print('Selected: $value');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          key: _menuKey,
          backgroundColor: Colors.greenAccent.shade700,
          foregroundColor: Colors.white,
          shape: null,
          onPressed: _showPopupMenu,
          child: const Icon(
            Icons.messenger_sharp,
            color: Colors.white,
          ),
        ),
        appBar: const CustomAppbar(),
        drawer: CustomNavigationDrawer(),
        body: Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => HomeScreen(homeController: _homeController),
            );
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required HomeController homeController,
  }) : _homeController = homeController;

  final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      const LoadingFullpage lp = LoadingFullpage(isLoading: true);
      if (_homeController.isLoading.value == true) {
        return const Center(
          child: lp,
        );
      } else {
        return MediaQuery.of(context).size.width > 1300
            ? Column(
                children: [
                  ReportSummary(
                    titles: const ["Employee", "Customers", "Bookings"],
                    datas: [
                      "You have 20 employees are working with you",
                      "1000+ Customer have an account",
                      "You have ${_homeController.bookings.value?.length.toString()} bookings done"
                    ],
                    icons: const [
                      Icons.people,
                      Icons.account_box,
                      Icons.schedule
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        labelText: 'Search Code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  TableBooking(controller: _homeController)
                ],
              )
            : const Center(
                child: Text("Not available on mobile"),
              );
      }
    });
  }
}
