//Date/time formatting and parsing functions.
import 'package:intl/intl.dart';

// ----------------------
//  DATE/TIME HELPERS
// ----------------------

// Format DateTime to string
String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
  return DateFormat(format).format(date);
}

// Parse string to DateTime
DateTime? parseDate(String dateStr, {String format = 'yyyy-MM-dd'}) {
  try {
    return DateFormat(format).parse(dateStr);
  } catch (e) {
    return null;
  }
}

// Convert DateTime to time string
String formatTime(DateTime date, {String format = 'HH:mm'}) {
  return DateFormat(format).format(date);
}

// Get current date in given format
String getCurrentDate({String format = 'yyyy-MM-dd'}) {
  return DateFormat(format).format(DateTime.now());
}
