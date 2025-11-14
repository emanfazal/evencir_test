import 'package:flutter/material.dart';
import '../utils/AppColors.dart';

class HydrationCard extends StatelessWidget {
  final double percent;
  final String footer;

  const HydrationCard({
    super.key,
    required this.percent,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = percent.clamp(0.0, 1.0);

    Widget activeDot({double width = 22}) => Container(
      width: width,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(999),
      ),
    );

    Widget inactiveDot({double width =8 }) => Container(
      width: width,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(999),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(clamped * 100).toInt()}%',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Hydration',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Log Now',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const Spacer(),


                SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2L + top blue bar
                      Row(
                        children: [
                          const Text(
                            '2 L',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          activeDot(),
                        ],
                      ),

                      const SizedBox(height: 4),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          inactiveDot(),
                          const SizedBox(height: 4),
                          inactiveDot(),
                          const SizedBox(height: 4),
                          activeDot(), // middle blue bar
                          const SizedBox(height: 4),
                          inactiveDot(),
                          const SizedBox(height: 4),
                          inactiveDot(),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Text(
                            '0 L',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          activeDot(width: 18),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.surfaceSoft,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '0ml',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1B3D45),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              footer,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
