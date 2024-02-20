import 'package:flutter/material.dart';

class CalendarProvider with ChangeNotifier {
  DateTime _selectedDate;

  CalendarProvider({required DateTime initialDate})
      : _selectedDate = initialDate;

  DateTime get selectedDate => _selectedDate;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
