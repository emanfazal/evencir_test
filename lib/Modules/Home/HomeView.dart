import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/Widgets/Calender.dart';
import '../../core/Widgets/DaySelectorRow.dart' show DaySelector;
import '../../core/Widgets/HydrationCard.dart';
import '../../core/Widgets/MetricCard.dart';
import '../../core/Widgets/SectionTitleRow.dart';
import '../../core/Widgets/WeekHeader.dart';
import '../../core/Widgets/WorkoutCard.dart';
import '../../core/utils/AppColors.dart';
import 'HomeController.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  void _openCalendarSheet(BuildContext context) {
    final initialDate = controller.weekDays.isNotEmpty
        ? controller.weekDays[controller.selectedDayIndex.value]
        : DateTime.now();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return CalendarBottomSheet(
          initialDate: initialDate,
          eventController: controller.eventController,
          onDateSelected: controller.setSelectedDate,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
  
    final int hour = DateTime.now().hour;
    final bool isDayTime = hour >= 6 && hour < 18;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // WEEK HEADER
          Obx(
                () => WeekHeader(
              weekLabel: controller.weekLabel,
              onTapWeek: () => _openCalendarSheet(context),
            ),
          ),
          const SizedBox(height: 16),

          // TODAY LABEL
          Obx(
                () => Text(
              controller.todayLabel,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // HORIZONTAL DAY SELECTOR
          Obx(
                () => DaySelector(
              selectedIndex: controller.selectedDayIndex,
              dayNumbers: controller.dayNumbers,
              onDaySelected: controller.onDaySelected,
            ),
          ),

          const SizedBox(height: 8),

          // CALENDAR HANDLE
          GestureDetector(
            onTap: () => _openCalendarSheet(context),
            child: Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // WORKOUTS
          SectionTitleRow(
            title: 'Workouts',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isDayTime
                      ? Icons.wb_sunny_outlined   // day → sun
                      : Icons.mode_night_outlined,    // night → moon
                  color: AppColors.textSecondary,
                  size: 18,
                ),
                const SizedBox(width: 4),
                const Text(
                  '9°',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const WorkoutCard(
            title: 'Upper Body',
            subtitle: 'December 22 - 25m - 30m',
          ),

          const SizedBox(height: 24),

          // MY INSIGHTS
          const Text(
            'My Insights',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: MetricCard(
                  value: '550',
                  unitLabel: 'Calories',
                  subtitle: '1950 Remaining',
                  showProgressBar: true,
                  progress: 550 / 2500,
                  minLabel: '0',
                  maxLabel: '2500',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricCard(
                  value: '75',
                  unitLabel: 'kg',
                  subtitle: '+1.6kg',
                  footer: 'Weight',
                  showChangeRow: true,
                  isPositiveChange: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const HydrationCard(
            percent: 0.0,
            footer: '500 ml added to water log',
          ),
        ],
      ),
    );
  }
}
