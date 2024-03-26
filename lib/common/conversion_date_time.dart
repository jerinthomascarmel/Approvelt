import 'dart:developer';

import 'package:intl/intl.dart';

String dateToTime(String date) {
  var val = DateFormat('hh:mm a').format(DateTime.now());
  return val.toString();
}

String dateToDate(String date) {
  var val = date.split(' ');
  return val[0];
}
