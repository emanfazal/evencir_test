// week_header.dart
import 'package:flutter/material.dart';
import '../../generated/assets.dart';
import '../utils/AppColors.dart';

class WeekHeader extends StatelessWidget {
  final String weekLabel;
  final VoidCallback? onTapWeek;

  const WeekHeader({
    super.key,
    required this.weekLabel,
    this.onTapWeek,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28, // close to your Figma
      child: Stack(
        alignment: Alignment.center,
        children: [

          const Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.notifications_none,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ),


          GestureDetector(
            onTap: onTapWeek,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Assets.iconsHomeclock,height: 20,width: 20,),
                const SizedBox(width: 6),
                Text(
                  weekLabel,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
