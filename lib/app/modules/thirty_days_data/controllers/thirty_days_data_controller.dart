import 'package:get/get.dart';
import 'package:thiran_task2/app/data/db/db_controller.dart';
import 'package:thiran_task2/app/modules/home/gitmodel_model.dart';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:thiran_task2/app/modules/home/widgets/snackbar_customized.dart';

class ThirtyDaysDataController extends GetxController {
  static const String baseURL =
      "https://api.github.com/search/repositories?q=created:>";

  int pageNoThirty = 1;
  List<Items> itemsofThrity = [];
  final RefreshController refreshController1 =
      RefreshController(initialRefresh: true);
  final sqldb = Get.put(SQLDB());

  @override
  void onClose() {
    refreshController1.dispose();
    super.onClose();
  }

//? *************Fetch Datas of 30 days****************//

  Future<bool> getReposOfThirtyDays({bool isRefresh = false}) async {
    final date = getDate(1);

    try {
      if (pageNoThirty >= 33) {
        refreshController1.loadNoData();
        return false;
      }
      print(pageNoThirty);
      final response = await http.get(
          Uri.parse("$baseURL$date&sort=stars&order=desc&page=$pageNoThirty"));
      if (response.statusCode > 400) {
        snackBarCustomized(
            title: "Oops ${response.statusCode}",
            messege: "Somthing went wrong. Please try after sometime");
      }
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final gitModel = gitModelFromJson(response.body);
        List<Items> list = gitModel.items!;
        itemsofThrity.addAll(list);
        pageNoThirty += 1;

        update();
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
//? *****************************//

//? *****************************//
  onRefreshPageThirty() async {
    final result = await getReposOfThirtyDays(isRefresh: true);
    if (result) {
      refreshController1.refreshCompleted();
    } else {
      refreshController1.refreshFailed();
    }
  }
  // ? ***************************//

//? *****************************//
  onLoadingPageThirty() async {
    final result = await getReposOfThirtyDays(isRefresh: true);
    if (result) {
      refreshController1.loadComplete();
    } else if (result == false && pageNoThirty == 34) {
      refreshController1.loadNoData();
    } else {
      refreshController1.loadFailed();
    }
  }
  //? ***************************//
//
//

//? ********Get Formatted Date **********//

  String getDate(int monthsToLess) {
    final DateTime now = DateTime(DateTime.now().year,
        DateTime.now().month - monthsToLess, DateTime.now().day);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(now);
    return date;
  }
  //? ***************************//

  //? ************* Add To SQFlite DB**************//

  addItemsToLocalDB() async {
    int count = 0;
    for (var i = 0; i < itemsofThrity.length; i++) {
      final isExisting = await sqldb.checkExistingInDB(
          repoName: itemsofThrity[i].name!, dbTypes: DbTypes.thirtyDays);
      if (!isExisting) {
        count++;
        await sqldb.writeToLocalDB(
            items: itemsofThrity[i], dbTypes: DbTypes.thirtyDays);
      }
    }
    snackBarCustomized(title: "Success", messege: "Data added successfully");
    log("Count is  $count  ");
    await sqldb.readFromDB(dbTypes: DbTypes.thirtyDays);
  }
  //? ***************************//

}
