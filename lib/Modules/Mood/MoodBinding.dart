import 'package:get/get.dart';
import 'MoodController.dart';

class MoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoodController>(() => MoodController());
  }
}
