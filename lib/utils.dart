import 'package:intl/intl.dart';

String formatCurrency(double value) {
  final formatter = NumberFormat.currency(locale: "pt_BR", symbol: "R\$");
  return formatter.format(value);
}
