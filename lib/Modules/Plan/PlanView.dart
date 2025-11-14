// lib/features/plan/plan_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/utils/AppColors.dart';
import 'PlanController.dart';

class PlanView extends StatelessWidget {
  const PlanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanController>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Row(
            children: const [
              Text(
                'Training Calendar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                'Save',
                style: TextStyle(
                  color: Color(0xFF6D8BFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 2,
          color: const Color(0xFF4C6FFF),
        ),

        Obx(
              () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.weekIndexLabel, // Week 2/8
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      controller.weekRangeLabel, // December 8–14
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Total: ${controller.totalMinutesThisWeek.value}min',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),

        const Divider(
          height: 1,
          thickness: 1,
          color: AppColors.surfaceSoft,
        ),

        Expanded(
          child: Obx(() {
            // 👇 explicitly depend on appointments so list rebuilds after drop
            final _ = controller.appointments.length;

            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: controller.weekDays.length,
              itemBuilder: (context, index) {
                final day = controller.weekDays[index];
                final dayLabel = DateFormat('EEE').format(day); // Mon
                final dayAppointments = controller.appointmentsForDay(day);

                return _DayRow(
                  key: ValueKey(day.toIso8601String()),
                  day: day,
                  dayLabel: dayLabel,
                  appointments: dayAppointments,
                  onDrop: (app) => controller.moveAppointmentToDay(app, day),
                );
              },
            );
          }),
        ),

        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFF1DCEB5),
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Week 2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'December 14–22',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                'Total: 60min',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DayRow extends StatelessWidget {
  final DateTime day;
  final String dayLabel;
  final List<Appointment> appointments;
  final void Function(Appointment) onDrop;

  const _DayRow({
    super.key,
    required this.day,
    required this.dayLabel,
    required this.appointments,
    required this.onDrop,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Appointment>(
      onWillAccept: (data) => data != null,
      // ✅ make sure drop callback really fires
      onAcceptWithDetails: (details) {
        onDrop(details.data);
      },
      builder: (context, candidateData, rejected) {
        final hasAppointment = appointments.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left day label (Mon / 8)
                  SizedBox(
                    width: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dayLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${day.day}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Right side → card if appointment exists
                  Expanded(
                    child: hasAppointment
                        ? Column(
                      children: appointments
                          .map(
                            (app) =>
                            _DraggableAppointmentCard(app: app),
                      )
                          .toList(),
                    )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),

            // Divider line under each day
            const Padding(
              padding: EdgeInsets.only(left: 72), // align with cards
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppColors.surfaceSoft,
              ),
            ),
          ],
        );
      },
    );
  }
}



class _DraggableAppointmentCard extends StatelessWidget {
  final Appointment app;

  const _DraggableAppointmentCard({required this.app});

  @override
  Widget build(BuildContext context) {
    final duration =
        app.endTime.difference(app.startTime).inMinutes; // 25–30m etc.

    return LongPressDraggable<Appointment>(
      data: app,
      feedback: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 90,
          ),
          child: _AppointmentCard(
            app: app,
            duration: duration,
            isDragging: true,
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _AppointmentCard(app: app, duration: duration),
      ),
      child: _AppointmentCard(app: app, duration: duration),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final Appointment app;
  final int duration;
  final bool isDragging;

  const _AppointmentCard({
    required this.app,
    required this.duration,
    this.isDragging = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF151821),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Left white rounded strip
          Container(
            width: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // dotted drag handle
          SizedBox(
            width: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                    (_) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.5),
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C6F8B),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                    (_) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.5),
                  child: Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C6F8B),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Main content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((app.notes ?? '').isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F295C),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      app.notes!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  app.subject,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Duration label
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              '${duration}m',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
