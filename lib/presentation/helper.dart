import 'package:intl/intl.dart';

class Helper {
  static String formatDateStringToTime(String startDate) {
    final DateTime date = DateTime.parse(startDate);

    String formattedTime = DateFormat('hh:mm a').format(date);

    return formattedTime.toLowerCase();
  }

  static String formatTextFieldDate([DateTime? startDate]) {
    final date = startDate ?? DateTime.now();

    String formattedDate = DateFormat('yyyy - MM - dd').format(date);

    return formattedDate;
  }

  static String formatDateString(String startDate) {
    final DateTime date = DateTime.parse(startDate);

    String formattedDate = DateFormat('dd - MM - yyyy').format(date);

    return formattedDate;
  }

  static DateTime formatDateStringToDate(String startDate) {
    final DateTime date = DateTime.parse(startDate);

    return date;
  }
}
