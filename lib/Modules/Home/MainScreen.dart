import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Modules/Home/HomeView.dart';
import '../../Modules/Plan/PlanView.dart';
import '../../core/Widgets/BottomNavBar.dart';
import '../../core/utils/AppColors.dart';
import '../Home/HomeController.dart';
import '../Mood/MoodView.dart';
import '../Plan/PlanController.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final PlanController planController = Get.find<PlanController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,


        bottomNavigationBar: const AppBottomNav(),


        body: Obx(
              () => IndexedStack(
            index: homeController.currentTabIndex.value,
            children:  [
              HomeView(),
              PlanView(),
              MoodView(),
              Center(
                child: Text("Profile Screen", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
