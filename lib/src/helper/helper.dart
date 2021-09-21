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

  static String getStringDate(String? date) {
    try {
      DateTime? _dateTime = DateTime.tryParse(date!);
      String stringDate = DateFormat(DateFormat.WEEKDAY).format(_dateTime!);
      stringDate = stringDate +
          " " +
          DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(_dateTime);
      return stringDate;
    } catch (ex) {}
    return "Err";
  }
}
