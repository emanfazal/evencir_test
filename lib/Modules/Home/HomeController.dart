import 'package:calendar_view/calendar_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final RxInt currentTabIndex = 0.obs;

  void changeTab(int index) => currentTabIndex.value = index;

  // calendar
  final EventController eventController = EventController();
  final RxInt selectedDayIndex = 0.obs;
  final RxList<DateTime> weekDays = <DateTime>[].obs;

  final Rx<DateTime> _currentDate = DateTime.now().obs;

  String get todayLabel {
    final fmt = DateFormat("EEE, d MMM yyyy");
    return "Today, ${fmt.format(_currentDate.value)}";
  }

  String get weekLabel {
    final d = _currentDate.value;
    final w = _weekOfMonth(d);
    final total = _weeksInMonth(d);
    return "Week $w/$total";
  }

  List<String> get dayNumbers =>
      weekDays.map((d) => d.day.toString()).toList();

  @override
  void onInit() {
    super.onInit();
    _generateCurrentWeek(_currentDate.value);
  }

  @override
  void onClose() {
    eventController.dispose();
    super.onClose();
  }

  void onDaySelected(int index) {
    selectedDayIndex.value = index;
    _currentDate.value = weekDays[index];
  }

  void setSelectedDate(DateTime date) {
    final onlyDate = DateTime(date.year, date.month, date.day);
    _currentDate.value = onlyDate;
    _generateCurrentWeek(onlyDate);
  }

  void _generateCurrentWeek(DateTime base) {
    final weekday = base.weekday; // 1..7
    final monday = base.subtract(Duration(days: weekday - 1));

    weekDays.assignAll(
      List.generate(
        7,
            (i) => DateTime(monday.year, monday.month, monday.day + i),
      ),
    );

    final idx = weekDays.indexWhere((d) => _isSameDate(d, base));
    selectedDayIndex.value = idx >= 0 ? idx : 0;
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  int _weekOfMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final firstWeekday = firstDay.weekday;
    final diff = date.day + (firstWeekday - 1);
    return ((diff - 1) ~/ 7) + 1;
  }

  int _weeksInMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    final firstWeekday = firstDay.weekday;
    final totalSlots = lastDay.day + (firstWeekday - 1);
    return (totalSlots / 7).ceil();
  }
}
