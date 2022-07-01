import 'package:easy_localization/easy_localization.dart';

class DateTimeHelper {
  static DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  static DateFormat dateTimeFormat = dateFormat.add_jm();
  static DateFormat monthNameFormat = DateFormat.MMMM();
  static DateFormat dayNameFormat = DateFormat.EEEE();
}
