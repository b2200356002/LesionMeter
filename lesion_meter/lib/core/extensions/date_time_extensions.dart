import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get ddMMyyyy => DateFormat.yMd().format(this);
}
