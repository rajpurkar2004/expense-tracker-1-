import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => ('\u{2089} ${price.toStringAsFixed(2)}');
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
