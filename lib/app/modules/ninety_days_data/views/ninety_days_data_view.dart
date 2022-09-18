import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thiran_task2/app/widgets/text.customized.dart';
import '../controllers/ninety_days_data_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:thiran_task2/app/modules/home/widgets/description_dialogue.dart';
import 'package:thiran_task2/app/modules/home/widgets/repository_tile.dart';

class NinetyDaysDataView extends GetView<NinetyDaysDataController> {
  NinetyDaysDataView({Key? key}) : super(key: key);

  final ninetyController = Get.put(NinetyDaysDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>ninetyController.addItemsToLocalDB(),
        backgroundColor: Colors.amber,
        label: const TextCustomized(
            text: "Save to phone storage",
            textSize: 16,
            textColor: Colors.white),
      ),
      body: GetBuilder<NinetyDaysDataController>(builder: (ctrl) {
        return SmartRefresher(
          enablePullUp: true,
          controller: ninetyController.refreshController2,
          onRefresh: () => ninetyController.onRefreshPageNinety(),
          onLoading: () => ninetyController.onLoadingPageNinety(),
          child: ListView.builder(
            itemCount: ninetyController.itemsofNinety.length,
            itemBuilder: (context, index) {
              final data = ninetyController.itemsofNinety[index];
              log("${ninetyController.itemsofNinety.length} --> 90 LENGTH");

              return RepositoryTile(
                avatarURL: data.owner!.avatarUrl.toString(),
                ontap: () => Get.dialog(DescriptionDialogue(data: data)),
                repoName: data.name ?? "Not available",
                ownerName: data.owner!.login ?? "Not availale",
                rating: data.stargazersCount == null
                    ? "Not availale"
                    : data.stargazersCount.toString(),
              );
            },
          ),
        );
      }),
    );
  }
}
