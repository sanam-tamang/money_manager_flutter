import 'package:money_manager/core/extention.dart';
import 'package:money_manager/enum/month_enum.dart';

String getMonthInString(int month) {
  String getmonth() {
    switch (month) {
      case 1:
        return Months.jan.name;
      case 2:
        return Months.feb.name;
      case 3:
        return Months.mar.name;
      case 4:
        return Months.apr.name;
      case 5:
        return Months.may.name;
      case 6:
        return Months.jun.name;
      case 7:
        return Months.jul.name;
      case 8:
        return Months.aug.name;
      case 9:
        return Months.sep.name;
      case 10:
        return Months.oct.name;
      case 11:
        return Months.nov.name;
      case 12:
        return Months.dec.name;
      default:
        return 'Invalid month';
    }
  }

  ;

  return getmonth().toCapitalizedFirstLater();
}
