abstract class ApiRoutesRepo {
  static const String baseUrl =
      'https://reservasihotelbe-dot-e-02-415004.as.r.appspot.com/api';
  static const String login = '/signin';
  static const String register = '/signup';
  static const String bookings = '/bookings';
  static const String adminBookings = '/admin$bookings';
  static const String roomTypes = '/roomtypes';
  static const String insertRoomType = '/roomtype';
  static const String uploadImage = '/upload';
  static const String roomAvailable = '/roomsavailable';
  static const String insertRoom = '/room';
}
