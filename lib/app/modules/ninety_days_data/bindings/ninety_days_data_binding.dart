import 'package:get/get.dart';

import '../controllers/ninety_days_data_controller.dart';

class NinetyDaysDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NinetyDaysDataController>(
      () => NinetyDaysDataController(),
    );
  }
}
