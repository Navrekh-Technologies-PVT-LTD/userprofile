import 'package:intl/intl.dart';

String ageCalculator({required DateTime? dob}) {
  if (dob == null) {
    return "";
  }
  DateTime now = DateTime.now();
  Duration difference = now.difference(dob);

  int age = (difference.inDays / 365).floor();
  return "$age";
}

String getDateFormat({required DateTime? date}) {
  if (date != null) {
    return DateFormat("dd/MM/yyyy").format(date);
  } else {
    return "-";
  }
}

String? getDateFormatForApi({required DateTime? date}) {
  if (date != null) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(date);
  } else {
    return null;
  }
}

String? gerDateTimeFormatForDiscount({required DateTime? date}) {
  if (date != null) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ").format(date.toLocal());
  } else {
    return null;
  }
}

DateTime getDateFormatParse({required String date}) {
  return DateFormat("dd/MM/yyyy").parse(date);
}

String getDateFormat2({required DateTime? date}) {
  if (date != null) {
    return DateFormat("dd MMM yyyy").format(date);
  } else {
    return "-";
  }
}

String getDateFormat3({required DateTime? date}) {
  if (date != null) {
    return DateFormat("E, h:mm a").format(date);
  } else {
    return "-";
  }
}

String getDateFormatTime({required DateTime? date}) {
  if (date != null) {
    return DateFormat.Hm().format(date);
  } else {
    return "-";
  }
}

String getDateFormatWithTime({required DateTime? date}) {
  if (date != null) {
    return DateFormat("dd/MM/yyyy").add_jm().format(date);
  } else {
    return "-";
  }
}

String getDateFormatForOrderStatus({required DateTime? date}) {
  if (date != null) {
    return DateFormat("E, dd MMM yyyy").format(date);
  } else {
    return "-";
  }
}

String getDateFormatForOrderStatus2({required DateTime? date}) {
  if (date != null) {
    return DateFormat("E, dd MMM yyyy -").add_jm().format(date);
  } else {
    return "-";
  }
}

String getDateFormatForDatePicker({required DateTime? date}) {
  if (date != null) {
    return DateFormat("dd-MM-yyyy").format(date);
  } else {
    return "";
  }
}

String getDateFormatMMMd({required DateTime? date}) {
  if (date != null) {
    return DateFormat("MMM d").format(date);
  } else {
    return "-";
  }
}

getDateForEvent({required DateTime? startDate, required DateTime? endDate, required String? dateOfEvent}) {
  if (dateOfEvent == "manny") {
    if (startDate?.month == endDate?.month && startDate?.year == endDate?.year) {
      return "${startDate?.day}-${getDateFormat2(date: endDate)}";
    }
    return "${getDateFormat2(date: startDate)} - ${getDateFormat2(date: endDate)}";
  }

  if (dateOfEvent == "one") {
    return getDateFormat2(date: startDate);
  }

  return "";
}

getTimeForEvent({required DateTime? startDate, required DateTime? endDate, required String? dateOfEvent}) {
  if (dateOfEvent == "manny") {
    return "${getDateFormat3(date: startDate)} - ${getDateFormat3(date: endDate)}";
  }

  if (dateOfEvent == "one") {
    return getDateFormat3(date: startDate);
  }

  return "";
}

int getMicroSecondFromDate({required DateTime date}) {
  return date.microsecondsSinceEpoch;
}

DateTime? getDateFromMicroSecond({required int? microsecond}) {
  if (microsecond != null) {
    return DateTime.fromMicrosecondsSinceEpoch(microsecond);
  } else {
    return null;
  }
}

String getDateFormatForChat({required DateTime? date}) {
  if (date != null) {
    return DateFormat.jm().format(date);
  } else {
    return "";
  }
}

String getDateFormatForChatDivider({required DateTime? date}) {
  if (date != null) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
      return 'Yesterday';
    } else {
      return DateFormat.yMMMMd().format(date);
    }
  } else {
    return "";
  }
}

String formatCountdown(int totalSeconds) {
  int minutes = totalSeconds ~/ 60; // Integer division to get full minutes
  int seconds = totalSeconds % 60; // Remainder to get remaining seconds

  String formattedMinutes = minutes.toString().padLeft(2, '0'); // Ensuring two digits
  String formattedSeconds = seconds.toString().padLeft(2, '0'); // Ensuring two digits

  return "$formattedMinutes:$formattedSeconds";
}
