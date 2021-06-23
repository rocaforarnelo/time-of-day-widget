library time_of_day_widget;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:time_of_day_widget/extensions/time_of_day_extension.dart';

class TimeOfDayWidget extends StatefulWidget {
  final List<TimeOfDayWidgetBuilder> timeOfDayWidgetBuilders;

  const TimeOfDayWidget({Key? key, required this.timeOfDayWidgetBuilders})
      : super(key: key);

  @override
  _TimeOfDayWidgetState createState() => _TimeOfDayWidgetState();
}

class _TimeOfDayWidgetState extends State<TimeOfDayWidget> {
  late ValueNotifier<int> _timeOfDayController;
  late Timer _timer;
  @override
  void initState() {
    super.initState();

    int currentIndex = getCurrentIndex();
    _timeOfDayController = ValueNotifier(currentIndex);
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _timeOfDayController.value = getCurrentIndex();
    });
  }

  int getCurrentIndex() {
    double periodDivider =
        24.0 / widget.timeOfDayWidgetBuilders.length.toDouble();
    double now = TimeOfDay.now().addHour(1).toDouble();
    int currentIndex = now ~/ periodDivider;
    return currentIndex;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: _timeOfDayController,
        builder: (context, currentIndex, child) {
          return widget.timeOfDayWidgetBuilders[currentIndex](
              context, TimeOfDay.now(), child);
        });
  }
}

typedef TimeOfDayWidgetBuilder = Widget Function(
    BuildContext context, TimeOfDay value, Widget? child);
