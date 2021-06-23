class TimeOfDayRangesLengthError extends ArgumentError {
  final num minimumLength;

  @pragma("vm:entry-point")
  TimeOfDayRangesLengthError(var message, this.minimumLength) : super(message);

  TimeOfDayRangesLengthError.value(num value, this.minimumLength,
      [String? name, String? message])
      : super.value(
            value,
            name,
            message ??
                "Length must be more than or equals " +
                    minimumLength.toString() +
                    ". Current length is " +
                    value.toString());
}

class TimeOfDayRangesError extends ArgumentError {
  final num index;

  @pragma("vm:entry-point")
  TimeOfDayRangesError(this.index);

  TimeOfDayRangesError.value(num value, this.index, [String? name])
      : super.value(
            value,
            name,
            "Range Error at index : " +
                index.toString() +
                ". Time of day ranges must not overlap");
}

class TimeOfDayTotalError extends ArgumentError {
  @pragma("vm:entry-point")
  TimeOfDayTotalError(
    var message,
  ) : super(message);

  TimeOfDayTotalError.value() : super.value("Must equal to 24 hours");
}
