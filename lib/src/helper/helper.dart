import 'package:intl/intl.dart';

class Helper {
  static String convertDate2Day(String? date) {
    try {
      DateTime? _dateTime = DateTime.tryParse(date!);
      return DateFormat(DateFormat.ABBR_WEEKDAY).format(_dateTime!);
    } catch (ex) {}
    return "Err";
  }

  static String GetPng(String? weatherState) {
    return "assets/images/png64/$weatherState.png";
  }
}
