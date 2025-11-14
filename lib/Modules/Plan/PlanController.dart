// lib/features/plan/PlanController.dart
import 'dart:ui';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart'; // for Appointment

class PlanController extends GetxController {
  final Rx<DateTime> currentWeekStart =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).obs;

  final RxList<Appointment> appointments = <Appointment>[].obs;

  late final DateTime planStart;
  late final DateTime planEnd;

  final RxInt totalMinutesThisWeek = 0.obs;


  List<DateTime> get weekDays => List.generate(
    7,
        (i) => currentWeekStart.value.add(Duration(days: i)),
  );

  String get weekIndexLabel {
    final startWeek = _weekNumber(planStart);
    final current = _weekNumber(currentWeekStart.value);
    final idx = (current - startWeek) + 1;
    final total = totalWeeks;
    return 'Week $idx/$total';
  }

  String get weekRangeLabel {
    final start = currentWeekStart.value;
    final end = start.add(const Duration(days: 6));
    final monthName = _monthName(start.month);
    return '$monthName ${start.day}–${end.day}';
  }

  int get totalWeeks {
    final startWeek = _weekNumber(planStart);
    final endWeek = _weekNumber(planEnd);
    return (endWeek - startWeek) + 1;
  }

  List<Appointment> appointmentsForDay(DateTime day) {
    return appointments
        .where((a) => _isSameDate(a.startTime, day))
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }


  @override
  void onInit() {
    super.onInit();

    planStart = DateTime(DateTime.now().year, DateTime.now().month, 1);
    planEnd = planStart.add(const Duration(days: 7 * 8 - 1)); // e.g. 8 weeks

    _seedDemoAppointments();
    _updateWeekSummary();
  }


  void moveAppointmentToDay(Appointment app, DateTime targetDay) {
    final index = appointments.indexOf(app);
    if (index == -1) return;

    final old = appointments[index];
    final duration = old.endTime.difference(old.startTime);

    final newStart = DateTime(
      targetDay.year,
      targetDay.month,
      targetDay.day,
      old.startTime.hour,
      old.startTime.minute,
    );

    final updated = Appointment(
      startTime: newStart,
      endTime: newStart.add(duration),
      subject: old.subject,
      notes: old.notes,
      color: old.color,
    );

    appointments[index] = updated;
    appointments.refresh();
    _updateWeekSummary();
  }


  void _seedDemoAppointments() {
    final monday = currentWeekStart.value;

    final demo = <Appointment>[
      Appointment(
        startTime: DateTime(monday.year, monday.month, monday.day, 8, 0),
        endTime: DateTime(monday.year, monday.month, monday.day, 8, 30),
        subject: 'Arm Blaster',
        notes: 'Arms Workout',
        color: const Color(0xFF222736),
      ),
      Appointment(
        startTime:
        DateTime(monday.year, monday.month, monday.day + 3, 18, 0),
        endTime:
        DateTime(monday.year, monday.month, monday.day + 3, 18, 30),
        subject: 'Leg Day Blitz',
        notes: 'Leg Workout',
        color: const Color(0xFF222736),
      ),
    ];

    appointments.assignAll(demo);
  }

  void _updateWeekSummary() {
    final start = currentWeekStart.value;
    final end = start.add(const Duration(days: 7));

    int minutes = 0;
    for (final a in appointments) {
      if (!a.startTime.isBefore(start) && a.startTime.isBefore(end)) {
        minutes += a.endTime.difference(a.startTime).inMinutes;
      }
    }
    totalMinutesThisWeek.value = minutes;
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  int _weekNumber(DateTime date) {
    final firstDay = DateTime(date.year, 1, 1);
    final diff = date.difference(firstDay).inDays + firstDay.weekday;
    return ((diff - 1) ~/ 7) + 1;
  }

  String _monthName(int month) =>
      const [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ][month - 1];
}
