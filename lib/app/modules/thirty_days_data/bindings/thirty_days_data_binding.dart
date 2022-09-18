import 'package:get/get.dart';

import '../controllers/thirty_days_data_controller.dart';

class ThirtyDaysDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThirtyDaysDataController>(
      () => ThirtyDaysDataController(),
    );
  }
}
