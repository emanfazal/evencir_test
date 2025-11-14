import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/AppColors.dart';

class DaySelector extends StatelessWidget {
  final RxInt selectedIndex;
  final List<String> dayNumbers;

  const DaySelector({
    super.key,
    required this.selectedIndex,
    required this.dayNumbers, required void Function(int index) onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    const weekdays = ['M', 'TU', 'W', 'TH', 'F', 'SA', 'SU'];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dayNumbers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Obx(() {
            final active = selectedIndex.value == index;

            return GestureDetector(
              onTap: () => selectedIndex.value = index,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weekdays[index % 7],
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active ? AppColors.green : Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: active
                            ? AppColors.primary
                            : AppColors.surfaceSoft,
                      ),
                    ),
                    child: Text(
                      dayNumbers[index],
                      style: TextStyle(
                        color: active
                            ? Colors.black
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (active)
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.green,
                      ),
                    ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
