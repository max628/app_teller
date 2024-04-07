import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String formatValidityDate(String dateString) {
    var inputDate = DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateString);
    var outputFormat = DateFormat('dd MMM yyyy').format(inputDate);

    return outputFormat;
  }

  static String formatDepositTimeWithAmFormat(String dateString) {
    var newStr =
        '${dateString.substring(0, 10)} ${dateString.substring(11, 23)}';
    DateTime dt = DateTime.parse(newStr);

    String formatedDate = DateFormat("yyyy-MM-dd").format(dt);

    return formatedDate;
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    //return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(dateTime);
    return DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").parse(dateTime);
  }

  static String convertIsoToString(String dateTime) {
    DateTime time = convertStringToDatetime(dateTime);
    String result = DateFormat('dd MMM yyyy hh:mm aa').format(time);

    return result;
  }

  static String convertIsoToString1(String dateTime) {
    if (dateTime == "") {
      dateTime = '2022-11-23T05:53:09.309Z';
    }
    DateTime time = convertStringToDatetime(dateTime);
    String result = DateFormat('MMM dd, yyyy').format(time);

    return result;
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS')
        .parse(dateTime, true)
        .toLocal();
  }

  static String isoToLocalTimeSubtract(String dateTime) {
    DateTime date = isoStringToLocalDate(dateTime);
    final currentDate = DateTime.now();
    final difference = currentDate.difference(date).inDays;

    return difference.toString();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    try {
      return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
    } catch (v) {
      return "--";
    }
  }

  static String isoStringToLocalFormattedDateOnly(String dateTime) {
    try {
      return DateFormat('dd MMM, yyyy').format(isoStringToLocalDate(dateTime));
    } catch (v) {
      return "--";
    }
  }

  static String localDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime.toUtc());
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }

  static String convertTimeToTime(String time) {
    return DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(time));
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(
      from.year,
      from.month,
      from.day,
    );
    to = DateTime(
      to.year,
      to.month,
      to.day,
    );

    return (to.difference(from).inHours / 24).round();
  }

  static int countLeapYears(DateTime startDate, DateTime endDate) {
    int count = 0;
    for (int year = startDate.year; year <= endDate.year; year++) {
      if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        count++;
      }
    }
    return count;
  }

  static bool isExpired(DateTime? endDate) {
    if (endDate != null) {
      final currentDate = DateTime.now();
      return endDate.isBefore(currentDate);
    }
    return false;
  }
}
