import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalenderWidget extends StatefulWidget {
  const TableCalenderWidget({super.key});

  @override
  State<TableCalenderWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<TableCalenderWidget> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        locale: "en_US",
        rowHeight: 40,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(Icons.arrow_back_ios, size: 16),
          rightChevronIcon: Icon(Icons.arrow_forward_ios, size: 16),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedDayPredicate: (day) => isSameDay(day, today),
        onDaySelected: _onDaySelected,
        focusedDay: today,
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: ColorsManager.orange.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: ColorsManager.orange,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayTextStyle: TextStyle(color: Colors.white),
        ));
  }
}
