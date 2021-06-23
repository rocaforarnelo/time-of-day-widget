library time_of_day_widget;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:time_of_day_widget/errors/time_of_day_range_errors.dart';
import 'package:time_of_day_widget/extensions/time_of_day_extension.dart';
import 'package:time_of_day_widget/models/time_of_day_range.dart';

class TimeOfDayWidget extends StatefulWidget {
  final List<TimeOfDayWidgetBuilder> timeOfDayWidgetBuilders;
  final Widget? child;
  const TimeOfDayWidget(
      {Key? key, required this.timeOfDayWidgetBuilders, this.child})
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

class TimeOfDayRangedWidget extends StatefulWidget {
  final List<TimeOfDayRange> timeOfDayRanges;
  final Widget? child;
  const TimeOfDayRangedWidget(
      {Key? key, required this.timeOfDayRanges, this.child})
      : super(key: key);

  @override
  _TimeOfDayRangedWidgetState createState() => _TimeOfDayRangedWidgetState();
}

class _TimeOfDayRangedWidgetState extends State<TimeOfDayRangedWidget> {
  late ValueNotifier<int> _timeOfDayController;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _validateRanges();
    int currentIndex = getCurrentIndex();
    _timeOfDayController = ValueNotifier(currentIndex);
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _timeOfDayController.value = getCurrentIndex();
    });
  }

  void _validateRanges() {
    if (widget.timeOfDayRanges.length < 2) {
      throw TimeOfDayRangesLengthError(null, 2);
    }
    _validateRangesContinuation();
  }

  void _validateRangesContinuation() {
    double total = 0;
    for (int i = 0; i < widget.timeOfDayRanges.length; i++) {
      TimeOfDayRange currentTimeOfDayRange = widget.timeOfDayRanges[i];
      int nextTimeOfDayRangeIndex =
          i + 1 == widget.timeOfDayRanges.length ? 0 : i + 1;
      TimeOfDayRange nextTimeOfDayRange =
          widget.timeOfDayRanges[nextTimeOfDayRangeIndex];
      if (currentTimeOfDayRange.to.toDouble() -
              nextTimeOfDayRange.from.toDouble() >
          0)
        throw ArgumentError("Range Error at index : " +
            i.toString() +
            ". Time of day ranges must not overlap");
      total += (currentTimeOfDayRange.to.toDouble() -
              currentTimeOfDayRange.from.toDouble())
          .abs();
    }
    if (total < 24.0) {
      throw TimeOfDayTotalError(null);
    }
  }

  int getCurrentIndex() {
    TimeOfDay now = TimeOfDay.now();
    for (int i = 0; i < widget.timeOfDayRanges.length; i++) {
      if (now.isInRangeOf(widget.timeOfDayRanges[i])) {
        return i;
      }
    }
    throw ArgumentError('Time of day range not found');
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
          return widget.timeOfDayRanges[currentIndex]
              .builder(context, TimeOfDay.now(), child);
        });
  }
}
