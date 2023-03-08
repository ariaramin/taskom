import 'package:shamsi_date/shamsi_date.dart';

extension DateHelperExtension on DateTime {
  int dateDifference(DateTime secondDate) {
    return DateTime(year, month, day)
        .difference(
          DateTime(
            secondDate.year,
            secondDate.month,
            secondDate.day,
          ),
        )
        .inDays;
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isInRange(DateTime startDate, DateTime endDate) {
    return (isAfter(startDate) || isSameDate(startDate)) &&
        (isBefore(endDate) || isSameDate(endDate));
  }

  String getJalaliDay() {
    final f = Jalali.fromDateTime(this).formatter;
    return f.d;
  }

  String getJalaliWeekDay() {
    final f = Jalali.fromDateTime(this).formatter;
    return f.wN;
  }

  String getJalaliDayAndMonth() {
    final f = Jalali.fromDateTime(this).formatter;
    return "${f.d} ${f.mN}";
  }
}
