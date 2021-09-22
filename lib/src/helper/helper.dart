import 'package:intl/intl.dart';

// ignore: slash_for_doc_comments
/************************Morteza*********************************
This class provide some helper method for converting date to day
and day abbreviation. Also getPng method provide the right png
for the given weather conditon.
****************************************************************/

class Helper {
  static String convertDate2Day(String? date) {
    try {
      DateTime? _dateTime = DateTime.tryParse(date!);
      return DateFormat(DateFormat.ABBR_WEEKDAY).format(_dateTime!);
    } catch (ex) {}
    return "Err";
  }

  static String getPng(String? weatherState) {
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
