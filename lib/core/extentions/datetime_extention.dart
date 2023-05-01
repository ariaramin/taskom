import 'package:shamsi_date/shamsi_date.dart';

extension DateHelperExtension on DateTime {
  DateTime changeDate(DateTime other) {
    return DateTime(other.year, other.month, other.day, hour, minute, second);
  }

  DateTime removeTime() {
    return DateTime(year, month, day);
  }

  DateTime removeUtc() {
    return DateTime(year, month, day, hour, minute, second);
  }

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
    return (startDate.isBefore(this) | startDate.isAtSameMomentAs(this)) &&
        (endDate.isAfter(this) | endDate.isAtSameMomentAs(this));
  }

  String getGregorianDate() {
    return "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
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
