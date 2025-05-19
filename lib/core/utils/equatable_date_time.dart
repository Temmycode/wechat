import 'package:equatable/equatable.dart';

class EquatableDateTime extends DateTime with EquatableMixin {
  EquatableDateTime(
    super.year, [
    super.month,
    super.day,
    super.hour,
    super.minute,
    super.second,
    super.millisecond,
    super.microsecond,
  ]);

  // Factory constructor to create from a regular DateTime
  factory EquatableDateTime.fromDateTime(DateTime dateTime) {
    return EquatableDateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond,
    );
  }

  @override
  List<Object> get props {
    return [year, month, day, hour, minute, second, millisecond, microsecond];
  }
}
