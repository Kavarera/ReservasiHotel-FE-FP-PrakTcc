import 'dart:js';

import 'package:reservasi_hotel_admin/models/booking/booking_model.dart';
import 'package:reservasi_hotel_admin/services/booking_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var totalEmployee = 0.obs;
  var totalProfit = 0.obs;
  var bookings = Rxn<BookingPrivateModel>();
  var isLoading = false.obs;
  var currentPage = 1.obs;
  final _permanentBookings = Rxn<BookingPrivateModel>();

  //singleton
  static HomeController get instance =>
      Get.find<HomeController>(tag: 'homeController');

  void changeNavigation(int value) {
    currentPage.value = value;
  }

  void _getPrivateBookingData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 5));
    try {
      BookingService bs = BookingService();
      final result = await bs.getPrivateBookingData();
      // await Future.delayed(const Duration(seconds: 10));
      bookings.value = result;
      _permanentBookings.value = result;
      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getPrivateBookingData();
    isLoading.value = true;
  }

  void searchBookingByCode(String kode) async {
    if (kode.isEmpty) {
      bookings.value = _permanentBookings.value;
      print('empty searcjh');
      return;
    }
    BookingService bs = BookingService();
    final result = await bs.getPrivateBookingData();
    // await Future.delayed(const Duration(seconds: 10));
    bookings.value = result;
    _permanentBookings.value = result;
    var filtered = _permanentBookings.value!.dataprivate
        .where((element) => element!.kodeBooking.contains(kode));
    bookings.value = BookingPrivateModel(
        length: filtered.length, dataprivate: filtered.toList());
    print('result searcjh');
    bookings.value!.dataprivate.forEach((element) {
      print(element!.kodeBooking);
    });
  }

  String _formatDate(String input) {
    final dateTime = DateTime.parse(input);
    final format = DateFormat('MM-dd-yyyy HH:mm');
    return format.format(dateTime);
  }

  void showDetailBooking(
      BuildContext context, Dataprivate bookingDataPrivate) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text('Booking Details'),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kode Booking : ${bookingDataPrivate.kodeBooking}'),
                Text('Check in : ${_formatDate(bookingDataPrivate.checkin)}'),
                Text('Days : ${bookingDataPrivate.days}'),
                Text('Customer Id : ${bookingDataPrivate.customerId}'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
