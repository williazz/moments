import 'package:intl/intl.dart';

final _formatter = NumberFormat.decimalPattern('en_us');

String withCommas(int number) => _formatter.format(number);
