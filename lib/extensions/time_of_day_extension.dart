import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  double toDouble() => this.hour.toDouble() + this.minute.toDouble() / 60.0;

  TimeOfDay addHour(int hour) {
    return this.replacing(hour: this.hour + hour, minute: this.minute);
  }
}
