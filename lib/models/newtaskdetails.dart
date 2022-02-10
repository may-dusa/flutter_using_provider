import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskTitle {
  String title = '';
}

class CardColors extends ChangeNotifier {
  static List<Color> cardColors = [
    const Color.fromRGBO(181, 247, 237, 1),
    const Color.fromRGBO(212, 227, 136, 1),
    const Color.fromRGBO(230, 199, 138, 1),
    const Color.fromRGBO(152, 140, 230, 1),
    const Color.fromRGBO(224, 135, 191, 1),
  ];

  void changeColor(int x) {
    selectedColor = x;
    notifyListeners();
  }

  int selectedColor = 0;

  List get colorList => cardColors;
}

class DateNames {
  static List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  static List days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  String monthName(int x) => months[x];
  String dayName(int x) => days[x];
}

class DateTimeValues extends ChangeNotifier {
  static DateTime defaultDate = DateTime.now();
  static TimeOfDay defaultTime = TimeOfDay.now();

  DateTime selectedDate = defaultDate;
  TimeOfDay selectedTime = defaultTime;

  String dateToText(DateTime date) {
    var _temp = DateNames().dayName(date.weekday) +
        ' , ' +
        date.day.toString() +
        ' ' +
        DateNames().monthName(date.month);
    return _temp;
  }

  String timeToText(TimeOfDay time) {
    var _temp = ((time.hour % 12) == 0 ? '12' : (time.hour % 12).toString()) +
        ' : ' +
        time.minute.toString() +
        ' ' +
        ((time.period == DayPeriod.am) ? 'A.M.' : 'P.M.');
    return _temp;
  }

  void dateChanged(DateTime changedDate) {
    selectedDate = changedDate;
    dateToText(changedDate);
    notifyListeners();
  }

  void timeChange(TimeOfDay changedTime) {
    selectedTime = changedTime;
    timeToText(changedTime);
    notifyListeners();
  }
}
