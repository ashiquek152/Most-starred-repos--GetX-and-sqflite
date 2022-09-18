import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:thiran_task2/app/modules/home/gitmodel_model.dart';
import 'package:thiran_task2/app/widgets/text.customized.dart';
class DescriptionDialogue extends StatelessWidget {
  const DescriptionDialogue({super.key, required this.data});
  final Items data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ), // height: heigh,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(),
                  child: TextCustomized(
                    text: data.name == null
                        ? "Repository name not available"
                        : data.name.toString().capitalizeFirst!,
                    textSize: 22,
                    textColor: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(),
                  child: TextCustomized(
                    text: data.description ?? "Description not available",
                    textSize: 16,
                    textColor: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
