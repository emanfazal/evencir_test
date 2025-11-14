import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../core/utils/AppColors.dart';
import 'MoodController.dart';

class MoodView extends StatelessWidget {
  const MoodView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MoodController>();

    return Stack(
    children: [
      Container(color: Colors.black),

      Positioned(
        top: -160,  // adjust +-20 if needed
        left: -60,
        right: -60,
        child: Container(
          height: 380,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.4),
              radius: 1.2,
              colors: [
                Color(0xFF47B2FF),
                Color(0xFF1B2F3F),
                Colors.transparent,
              ],
              stops: [0.0, 0.35, 1.0],
            ),
          ),
        ),
      ),

      SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 24),
              child: Text(
                'Mood',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Start your day',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 16, top: 4),
              child: Text(
                'How are you feeling at the Moment?',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  height: 1.3,
                ),
              ),
            ),

            const Spacer(),

            Center(
              child: SizedBox(
                width: 260,
                height: 260,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(260, 260),
                      painter: _MoodRingPainter(),
                    ),

                    Obx(
                          () => SleekCircularSlider(
                        min: 0,
                        max: 100,
                        initialValue: controller.moodValue.value,
                        onChange: controller.onSliderChanged,
                        appearance: CircularSliderAppearance(
                          size: 280,
                          startAngle: 150,
                          angleRange: 300,
                          customWidths: CustomSliderWidths(
                            trackWidth: 0,
                            progressBarWidth: 24,
                            handlerSize: 20,
                            shadowWidth: 0,
                          ),
                          customColors: CustomSliderColors(
                            trackColor: Colors.transparent,
                            progressBarColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            dotColor: Colors.white,
                          ),
                        ),
                        innerWidget: (_) => Obx(
                              () => SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                              controller.emojiAsset.value,
                              fit: BoxFit.none,
                              height: 50,
                              width: 50
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Obx(
                  () => Center(
                child: Text(
                  controller.moodLabel.value,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    ],
    );
    ;
  }
}

class _MoodRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 12;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final gradient = SweepGradient(
      startAngle: -pi / 2,
      endAngle: 3 * pi / 2,
      colors: const [
        Color(0xFFF99955),
        Color(0xFFF28DB3),
        Color(0xFFC9BBEF),
        Color(0xFFE2F0EE),
        Color(0xFF6EB9AD),
        Color(0xFFF99955),
      ],
      stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, 2 * pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;}
