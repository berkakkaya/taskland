import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeLocalization on DateTime {
  String localizedDate(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;

    final String day = DateFormat.d(locale).format(this);
    final String month = DateFormat.MMMM(locale).format(this);
    final String year = DateFormat.y(locale).format(this);

    return "$day $month $year";
  }
}
