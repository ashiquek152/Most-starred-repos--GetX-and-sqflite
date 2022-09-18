import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:thiran_task2/app/widgets/text.customized.dart';

import '../controllers/thirty_days_data_controller.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:thiran_task2/app/modules/home/widgets/description_dialogue.dart';
import 'package:thiran_task2/app/modules/home/widgets/repository_tile.dart';

class ThirtyDaysDataView extends GetView<ThirtyDaysDataController> {
  ThirtyDaysDataView({Key? key}) : super(key: key);

  final thirtyController = Get.put(ThirtyDaysDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>thirtyController.addItemsToLocalDB(),
        backgroundColor: Colors.amber,
        label: const TextCustomized(
            text: "Save to phone storage",
            textSize: 16,
            textColor: Colors.white),
      ),
      body: GetBuilder<ThirtyDaysDataController>(builder: (ctrl) {
        return SmartRefresher(
          enablePullUp: true,
          controller: thirtyController.refreshController1,
          onRefresh: () => thirtyController.onRefreshPageThirty(),
          onLoading: () => thirtyController.onLoadingPageThirty(),
          child: ListView.builder(
            itemCount: thirtyController.itemsofThrity.length,
            itemBuilder: (context, index) {
              final data = thirtyController.itemsofThrity[index];
              log("Thirty --> ${thirtyController.itemsofThrity.length}");
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
