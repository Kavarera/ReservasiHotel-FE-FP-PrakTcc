import 'package:fe_sendiri_prak_tcc_fp/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class TableBooking extends StatelessWidget {
  final HomeController controller;
  const TableBooking({
    super.key,
    required this.controller,
  });

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
                rows: controller.bookings.value!.data.map((data) {
                  return DataRow(
                    cells: [
                      DataCell(Text(data.checkin)), // display checkin date
                      DataCell(Text(data.checkin)), // display checkin date
                      DataCell(Text(data.checkin)), // display checkin date
                      DataCell(Text(data.checkin)), // display checkin date
                      DataCell(
                          Text(data.days.toString())), // display number of days
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
}
