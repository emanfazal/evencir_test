import 'package:get/get.dart';
import 'PlanController.dart';

class PlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanController>(() => PlanController());
  }
}
