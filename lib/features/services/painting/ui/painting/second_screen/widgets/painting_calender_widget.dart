import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PaintingCalenderWidget extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const PaintingCalenderWidget({super.key, this.onDateSelected});

  @override
  State<PaintingCalenderWidget> createState() => _PaintingCalenderWidget();
}

class _PaintingCalenderWidget extends State<PaintingCalenderWidget> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
    widget.onDateSelected?.call(day);
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
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: ColorsManager.yellow,
            fontWeight: FontWeight.w700,
          ),
          weekendStyle: TextStyle(
            color: ColorsManager.yellow,
            fontWeight: FontWeight.w700,
          ),
        ),
        selectedDayPredicate: (day) => isSameDay(day, today),
        onDaySelected: _onDaySelected,
        focusedDay: today,
        enabledDayPredicate: (day) {
          final now = DateTime.now();
          final todayOnly = DateTime(now.year, now.month, now.day);
          return !day.isBefore(todayOnly);
        },
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: ColorsManager.yellow.withValues(alpha: 0.7),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: ColorsManager.yellow,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayTextStyle: TextStyle(color: Colors.white),
        ));
  }
}
