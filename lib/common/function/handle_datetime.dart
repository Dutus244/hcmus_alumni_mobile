import 'package:intl/intl.dart';

String handleDatetime(String data) {
  DateTime dateTime = DateTime.parse(data);
  dateTime = dateTime.toLocal();
  return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
}