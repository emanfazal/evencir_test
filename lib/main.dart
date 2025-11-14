import 'package:evencir_test/Modules/Home/MainScreen.dart';
import 'package:evencir_test/Modules/Mood/MoodController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Modules/Home/HomeController.dart';
import 'Modules/Plan/PlanController.dart';
import 'core/Theme/AppTheme.dart';
import 'core/routes/AppPages.dart';


void main() {
  runApp(const MyApp());
  Get.put<HomeController>(HomeController(), permanent: true);
  Get.put<PlanController>(PlanController(), permanent: true);
  Get.put<MoodController>(MoodController(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: AppTheme.dark,
     home: MainScreen(),
      getPages: AppPages.pages,
    );
  }
}
