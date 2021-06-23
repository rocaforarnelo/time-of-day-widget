import 'package:flutter/material.dart';
import 'package:time_of_day_widget/models/time_of_day_range.dart';

extension TimeOfDayExtension on TimeOfDay {
  double toDouble() =>
      (this.hour % 23).toDouble() + this.minute.toDouble() / 60.0;

  TimeOfDay addHour(int hour) {
    return this.replacing(hour: (this.hour + hour) % 23, minute: this.minute);
  }

  bool isLessThan(TimeOfDay other) {
    return this.toDouble() < other.toDouble();
  }

  bool isInRangeOf(TimeOfDayRange timeOfDayRange) {
    bool isAfterMidnight = timeOfDayRange.to.isLessThan(timeOfDayRange.from);
    DateTime now = DateTime.now();
    DateTime from = DateTime(now.year, now.month, now.day,
        timeOfDayRange.from.hour, timeOfDayRange.from.minute);
    DateTime to = DateTime.now().add(Duration(days: isAfterMidnight ? 1 : 0));
    to = DateTime(to.year, to.month, to.day, timeOfDayRange.to.hour,
        timeOfDayRange.to.minute);
    DateTime current =
        DateTime.now().add(Duration(days: isAfterMidnight ? 1 : 0));
    current = DateTime(
        current.year, current.month, current.day, this.hour, this.minute);
    bool isAfter = current.isAfter(from);
    bool isBefore = current.isBefore(to);
    return isAfter && isBefore;
  }
}
