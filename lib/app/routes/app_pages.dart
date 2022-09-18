import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/ninety_days_data/bindings/ninety_days_data_binding.dart';
import '../modules/ninety_days_data/views/ninety_days_data_view.dart';
import '../modules/thirty_days_data/bindings/thirty_days_data_binding.dart';
import '../modules/thirty_days_data/views/thirty_days_data_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.THIRTY_DAYS_DATA,
      page: () =>  ThirtyDaysDataView(),
      binding: ThirtyDaysDataBinding(),
    ),
    GetPage(
      name: _Paths.NINETY_DAYS_DATA,
      page: () =>  NinetyDaysDataView(),
      binding: NinetyDaysDataBinding(),
    ),
  ];
}
