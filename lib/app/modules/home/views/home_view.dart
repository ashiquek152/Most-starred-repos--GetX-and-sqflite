import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:thiran_task2/app/modules/ninety_days_data/views/ninety_days_data_view.dart';
import 'package:thiran_task2/app/modules/thirty_days_data/views/thirty_days_data_view.dart';
import 'package:thiran_task2/app/widgets/text.customized.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const TextCustomized(
          textSize: 20,
          text: "Most Starred Repositories",
          fontWeight: FontWeight.bold,
          textColor: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: controller.tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                  color: Colors.amber,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(text: 'Last 30 days'),
                  Tab(text: 'Last 90 days'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  ThirtyDaysDataView(),
                  NinetyDaysDataView()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
