import 'package:flutter/material.dart';
import '../utils/AppColors.dart';

class MetricCard extends StatelessWidget {
  final String value;          // "550", "75"
  final String unitLabel;      // "Calories", "kg"
  final String subtitle;       // "1950 Remaining" / "+1.6kg"
  final String? footer;        // e.g. "Weight" (null for calories card)

  // calories card options
  final bool showProgressBar;
  final double progress;       // 0.0–1.0
  final String? minLabel;      // "0"
  final String? maxLabel;      // "2500"


  final bool showChangeRow;
  final bool isPositiveChange;

  const MetricCard({
    super.key,
    required this.value,
    required this.unitLabel,
    required this.subtitle,
    this.footer,
    this.showProgressBar = false,
    this.progress = 0.0,
    this.minLabel,
    this.maxLabel,
    this.showChangeRow = false,
    this.isPositiveChange = true,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const WidgetSpan(child: SizedBox(width: 4)),
                TextSpan(
                  text: unitLabel,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          if (!showChangeRow)

            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 14,
              ),
            ),

          if (showChangeRow)

            Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPositiveChange
                        ? Icons.arrow_outward_rounded
                        : Icons.arrow_downward_rounded,
                    size: 12,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

          const SizedBox(height: 10),


          if (showProgressBar) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  minLabel ?? '',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                Text(
                  maxLabel ?? '',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              height: 7,
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: clampedProgress,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF3FD3C7), // teal-ish start
                          AppColors.primary, // blue end
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],


          if (footer != null && !showProgressBar) ...[
            const SizedBox(height: 22),
            Text(
              footer!,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
