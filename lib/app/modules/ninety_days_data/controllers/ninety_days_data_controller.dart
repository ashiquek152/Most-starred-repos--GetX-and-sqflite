import 'package:get/get.dart';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:thiran_task2/app/data/db/db_controller.dart';
import 'package:thiran_task2/app/modules/home/gitmodel_model.dart';
import 'package:thiran_task2/app/modules/home/widgets/snackbar_customized.dart';

class NinetyDaysDataController extends GetxController {
  static const String baseURL =
      "https://api.github.com/search/repositories?q=created:>";

  int pageNoNinety = 1;
  List<Items> itemsofNinety = [];

  final RefreshController refreshController2 =
      RefreshController(initialRefresh: true);

  final sqldb = Get.put(SQLDB());

  @override
  void onClose() {
    refreshController2.dispose();
    super.onClose();
  }
//? *************Fetch Datas of 90 days****************/

  Future<bool> getReposOfThirtyDays({bool isRefresh = false}) async {
    final date = getDate(3);

    try {
      if (pageNoNinety >= 33) {
        refreshController2.loadNoData();
        return false;
      }
      print(pageNoNinety);
      final response = await http.get(
          Uri.parse("$baseURL$date&sort=stars&order=desc&page=$pageNoNinety"));
      if (response.statusCode > 400) {
        snackBarCustomized(
            title: "Oops ${response.statusCode}",
            messege: "Somthing went wrong. Please try after sometime");
      }
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final gitModel = gitModelFromJson(response.body);
        List<Items> list = gitModel.items!;
        itemsofNinety.addAll(list);
        pageNoNinety += 1;

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
  onRefreshPageNinety() async {
    final result = await getReposOfThirtyDays(isRefresh: true);
    if (result) {
      refreshController2.refreshCompleted();
    } else {
      refreshController2.refreshFailed();
    }
  }
  // ? ***************************//

//? *****************************//
  onLoadingPageNinety() async {
    final result = await getReposOfThirtyDays(isRefresh: true);
    if (result) {
      refreshController2.loadComplete();
    } else if (result == false && pageNoNinety == 34) {
      refreshController2.loadNoData();
    } else {
      refreshController2.loadFailed();
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
    for (var i = 0; i < itemsofNinety.length; i++) {
      final isExisting = await sqldb.checkExistingInDB(
          repoName: itemsofNinety[i].name!, dbTypes: DbTypes.ninetyDays);
      if (!isExisting) {
        count++;
        await sqldb.writeToLocalDB(
            items: itemsofNinety[i], dbTypes: DbTypes.ninetyDays);
      }
    }
    snackBarCustomized(title: "Success", messege: "Data added successfully");
    log("Count is  $count  ");
    await sqldb.readFromDB(dbTypes: DbTypes.ninetyDays);
  }
  //? ***************************//

}
