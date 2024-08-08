import 'package:floor/floor.dart';

class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime fromSqlValue(int? sqlValue) {
    return DateTime.fromMillisecondsSinceEpoch(sqlValue ?? 0);
  }

  @override
  int toSqlValue(DateTime? value) {
    return value?.millisecondsSinceEpoch ?? 0;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
