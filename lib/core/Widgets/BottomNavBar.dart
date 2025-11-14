import 'package:evencir_test/Modules/Home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/assets.dart';
import '../utils/AppColors.dart';

class AppBottomNav extends GetView<HomeController> {
  const AppBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        final index = controller.currentTabIndex.value;

        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.background,
          elevation: 0,
          currentIndex: index,
          onTap: controller.changeTab,
          selectedItemColor: Colors.white,
          unselectedItemColor: AppColors.textMuted,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),

          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                index == 0 ? Assets.iconsNutritionselected : Assets.iconsNutrition,
                height: 24,
              ),
              label: 'Nutrition',
            ),

            BottomNavigationBarItem(
              icon: Image.asset(
                index == 1 ? Assets.iconsPlanselected : Assets.iconsPlan,
                height: 24,
              ),
              label: 'Plan',
            ),

            BottomNavigationBarItem(
              icon: Image.asset(
                index == 2 ? Assets.iconsMoodselected : Assets.iconsMood,
                height: 24,
              ),
              label: 'Mood',
            ),

            BottomNavigationBarItem(
              icon: Image.asset(
                index == 3 ? Assets.iconsProfile: Assets.iconsProfile,
                height: 24,
              ),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}

