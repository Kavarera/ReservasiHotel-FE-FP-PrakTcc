import 'package:fe_sendiri_prak_tcc_fp/controllers/home_controller.dart';
import 'package:fe_sendiri_prak_tcc_fp/models/booking/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableBooking extends StatelessWidget {
  final BookingPrivateModel controller;
  final HomeController homeController;
  const TableBooking(
      {super.key, required this.controller, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            surfaceTintColor: Colors.white,
            borderOnForeground: true,
            elevation: 60,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text('Kode Booking'),
                  ),
                  DataColumn(
                    label: Text('Checkin'),
                  ),
                  DataColumn(
                    label: Text('Days'),
                  ),
                  DataColumn(
                    label: Text('Nomor Kamar'),
                  ),
                  DataColumn(
                    label: Text('Aksi'),
                  )
                  // row 1
                ],
                rows: controller.dataprivate.map((data) {
                  return DataRow(
                    cells: [
                      DataCell(Text(data!.kodeBooking)), // display checkin date
                      DataCell(Text(
                          formatDate(data.checkin))), // display checkin date
                      DataCell(
                          Text(data.days.toString())), // display checkin date
                      DataCell(
                          Text(data.roomId.toString())), // display checkin date
                      DataCell(ElevatedButton(
                          onPressed: () {
                            homeController.showDetailBooking(context, data);
                          },
                          child:
                              const Text("Detail"))), // display number of days
                      // add more cells for other columns if needed
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(String input) {
    final dateTime = DateTime.parse(input);
    final format = DateFormat('MM-dd-yyyy HH:mm');
    return format.format(dateTime);
  }
}
