import 'package:evencir_test/Modules/Mood/MoodBinding.dart';
import 'package:evencir_test/Modules/Mood/MoodView.dart';
import 'package:evencir_test/Modules/Plan/PlanBinding.dart';
import 'package:evencir_test/Modules/Plan/PlanView.dart';
import 'package:get/get.dart';


import '../../Modules/Home/HomeBindingss.dart';
import '../../Modules/Home/HomeView.dart';
import 'AppRoutes.dart';



class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.plan,
      page: () => const PlanView(),
      binding: PlanBinding(),
    ),
    GetPage(
      name: Routes.mood,
      page: () => const MoodView(),
      binding: MoodBinding(),
    ),
  ];
}
