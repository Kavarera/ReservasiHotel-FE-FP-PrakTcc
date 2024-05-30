import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey _menuKey = GlobalKey();

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
            items: [
              'Item 1',
              'Item 2',
              'Item 3',
            ].map((String value) {
              return PopupMenuItem<String>(
                value: value,
                child: Container(
                  width: 200, // Atur lebar item menu
                  height: 150, // Atur tinggi item menu
                  alignment: Alignment.center,
                  child: Text(value),
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
            child: const Icon(
              Icons.messenger_sharp,
              color: Colors.white,
            ),
            onPressed: _showPopupMenu),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Tinggal-in",
            style: GoogleFonts.firaSans(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        drawer: Drawer(
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
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Room Types',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Employees',
                  style: TextStyle(color: Colors.white),
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
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text('Mode Malam',
              //         style: TextStyle(color: Colors.white)),
              //     Switch(value: false, onChanged: (v) {})
              //   ],
              // )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
