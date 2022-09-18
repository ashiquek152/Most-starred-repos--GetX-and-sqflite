import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:thiran_task2/app/data/db/db_controller.dart';

import 'app/routes/app_pages.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   final sqldb =Get.put(SQLDB());
  sqldb.iniTializeDB();
  runApp(
    GetMaterialApp(
      title: "ThiranT2",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
