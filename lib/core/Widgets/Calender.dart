// calendar_bottom_sheet.dart
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/utils/AppColors.dart';

class CalendarBottomSheet extends StatefulWidget {
  final DateTime initialDate;
  final EventController eventController;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarBottomSheet({
    Key? key,
    required this.initialDate,
    required this.eventController,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  late DateTime _selectedDate;
  late DateTime _focusedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _focusedMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 371,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top drag handle
              Center(
                child: Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Calendar
              Expanded(
                child: MonthView<Object?>(
                  controller: widget.eventController,
                  initialMonth: _focusedMonth,
                  minMonth: DateTime(2020),
                  maxMonth: DateTime(2030),
                  showBorder: false,
                  hideDaysNotInMonth: true,
                  cellAspectRatio: 1.25,
                  borderColor: AppColors.surface,

                  // ---- Header:  ← Sep 2024 → ----
                  headerStringBuilder: (date, {secondaryDate}) {
                    return DateFormat('MMM yyyy').format(date); // Sep 2024
                  },
                   headerStyle: HeaderStyle(
                headerTextStyle: const TextStyle(
                fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                headerPadding:
                const EdgeInsets.only(bottom: 12, left: 4, right: 4),
                headerMargin: EdgeInsets.zero,
                titleAlign: TextAlign.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                decoration: const BoxDecoration(
                  color: AppColors.surface,
                ),

                leftIconConfig: const IconDataConfig(
                  color: Colors.white,
                  size: 20,
                  padding: EdgeInsets.all(4),
                ),
                rightIconConfig: const IconDataConfig(
                  color: Colors.white,
                  size: 20,
                  padding: EdgeInsets.all(4),
                ),
              ),


                  onPageChange: (date, pageIndex) {
                    setState(() => _focusedMonth = date);
                  },

                  // ---- Weekday row: MON TUE WED ... ----
                  weekDayBuilder: (int index) {
                    const labels = [
                      'MON',
                      'TUE',
                      'WED',
                      'THU',
                      'FRI',
                      'SAT',
                      'SUN',
                    ];
                    return Center(
                      child: Text(
                        labels[index],
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  },


                  cellBuilder: (
                      DateTime date,
                      List<CalendarEventData<Object?>> events,
                      bool isToday,
                      bool isInMonth,
                      bool hideDaysNotInMonth,
                      ) {
                    if (!isInMonth) return const SizedBox.shrink();

                    final isSelected = _isSameDate(date, _selectedDate);
                    final isCurrentDay = _isSameDate(date, DateTime.now());

                    final textColor = isSelected
                        ? Colors.white
                        : (isCurrentDay
                        ? Colors.white
                        : AppColors.textPrimary);

                    return Center(
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                            color: const Color(0xFF17C964), // green ring
                            width: 2,
                          )
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: textColor,
                          ),
                        ),
                      ),
                    );
                  },

                  onCellTap: (events, date) {
                    setState(() => _selectedDate = date);
                    widget.onDateSelected(date);
                    Navigator.of(context).pop();
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Bottom drag handle (purple bar like Figma)
              Center(
                child: Container(
                  width: 120,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C7BAF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
