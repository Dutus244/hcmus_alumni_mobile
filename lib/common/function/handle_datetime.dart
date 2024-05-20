import 'package:intl/intl.dart';

String handleDatetime(String data) {
  DateTime dateTime = DateTime.parse(data);
  dateTime = dateTime.toLocal();
  return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
}

String timeDifference(String data) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.parse(data);
  dateTime = dateTime.toLocal();

  Duration diff = now.difference(dateTime);

  if (diff.inSeconds < 60) {
    return '${diff.inSeconds} giây trước';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} phút trước';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} tiếng trước';
  } else if (diff.inDays < 30) {
    return '${diff.inDays} ngày trước';
  } else if (diff.inDays < 365) {
    int months = (diff.inDays / 30).floor();
    return '$months tháng trước';
  } else {
    int years = (diff.inDays / 365).floor();
    return '$years năm trước';
  }
}

String timePost(String data) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.parse(data);
  dateTime = dateTime.toLocal();

  Duration diff = now.difference(dateTime);

  if (diff.inSeconds < 60) {
    return '${diff.inSeconds}s';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes}p';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} giờ';
  } else if (diff.inDays < 7) {
    return '${diff.inDays} ngày';
  } else if (DateTime.now().year - dateTime.year == 0) {
    return '${dateTime.day} Th${dateTime.month}';
  } else {
    return '${dateTime.day} Th${dateTime.month}, ${dateTime.year}';
  }
}

String timeCreateGroup(String data) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.parse(data);
  dateTime = dateTime.toLocal();

  return '${dateTime.day} tháng ${dateTime.month}, ${dateTime.year}';
}