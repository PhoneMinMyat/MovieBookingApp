import 'package:intl/intl.dart';

class DateVO {
  String? date;
  bool? isSelected;
  int? weekday;

  
  DateVO({
    this.date,
    this.isSelected,
    this.weekday,
  });

  List<String> weekDayList = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  String getWeekday() {
    return weekDayList[weekday! - 1 ];
  }

  String getDay(){
    DateTime tempDate =  DateFormat("yyyy-MM-dd").parse(date ?? '');
    String day = DateFormat("d").format(tempDate);
    return day;
  }
}
