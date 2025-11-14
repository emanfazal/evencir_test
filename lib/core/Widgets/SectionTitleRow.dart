import 'package:flutter/material.dart';
import '../utils/AppColors.dart';

class SectionTitleRow extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionTitleRow({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}
