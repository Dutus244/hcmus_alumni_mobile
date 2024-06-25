import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/global.dart';
import 'package:intl/intl.dart';

String handleDateTime1(String data) {
  DateTime dateTime = DateTime.parse(data);
  dateTime = dateTime.toLocal();
  return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
}

String handleDateTime2(String data) {
  DateTime dateTime = DateTime.parse(data);
  dateTime = dateTime.toLocal();
  return '${dateTime.day} ${translate('month').toLowerCase()} ${dateTime.month}, ${dateTime.year}';
}

String handleDateTime3(String data) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.parse(data);
  dateTime = dateTime.toLocal();
  if (now.year == dateTime.year && now.month == dateTime.month && now.day == dateTime.day) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
  if (now.year == dateTime.year) {
    if (Global.storageService.getDeviceLanguage() == "en") {
      return '${handleMonthAbbreviation(dateTime.month)} ${dateTime.day}';
    }
    return '${dateTime.day} Th${dateTime.month}';
  }
  if (Global.storageService.getDeviceLanguage() == "en") {
    return '${handleMonthAbbreviation(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
  }
  return '${dateTime.day} Th${dateTime.month}, ${dateTime.year}';
}

String handleTimeDifference1(String data) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.parse(data);
  dateTime = dateTime.toLocal();

  Duration diff = now.difference(dateTime);

  if (diff.inSeconds < 60) {
    return '${diff.inSeconds} ${translate('seconds_ago').toLowerCase()}';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} ${translate('minutes_ago').toLowerCase()}';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} ${translate('hours_ago').toLowerCase()}';
  } else if (diff.inDays < 30) {
    return '${diff.inDays} ${translate('days_ago').toLowerCase()}';
  } else if (diff.inDays < 365) {
    int months = (diff.inDays / 30).floor();
    return '$months ${translate('months_ago').toLowerCase()}';
  } else {
    int years = (diff.inDays / 365).floor();
    return '$years ${translate('years_ago').toLowerCase()}';
  }
}

String handleMonthAbbreviation(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
  }
  return "";
}

String handleTimeDifference2(String data) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.parse(data);
  dateTime = dateTime.toLocal();

  Duration diff = now.difference(dateTime);

  if (diff.inSeconds < 60) {
    return '${diff.inSeconds} ${translate(('second').toLowerCase())}';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} ${translate(('minute').toLowerCase())}';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} ${translate(('hour').toLowerCase())}';
  } else if (diff.inDays < 7) {
    return '${diff.inDays} ${translate(('day').toLowerCase())}';
  } else if (DateTime.now().year - dateTime.year == 0) {
    if (Global.storageService.getDeviceLanguage() == "en") {
      return '${handleMonthAbbreviation(dateTime.month)} ${dateTime.day}';
    }
    return '${dateTime.day} Th${dateTime.month}';
  } else {
    if (Global.storageService.getDeviceLanguage() == "en") {
      return '${handleMonthAbbreviation(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
    }
    return '${dateTime.day} Th${dateTime.month}, ${dateTime.year}';
  }
}
