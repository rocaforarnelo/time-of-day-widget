library time_of_day_widget;

import 'package:flutter/material.dart';
import 'package:time_of_day_widget/time_of_day_widget.dart';

class TimeOfDayWidgetItem {
  final TimeOfDayWidgetBuilder timeOfDayWidgetBuilder;

  TimeOfDayWidgetItem({required this.timeOfDayWidgetBuilder});
}

class TimeOfDayRange {
  final TimeOfDay from;
  final TimeOfDay to;
  final TimeOfDayWidgetBuilder builder;
  TimeOfDayRange({
    required this.from,
    required this.to,
    required this.builder,
  });
}
