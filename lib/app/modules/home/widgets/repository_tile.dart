import 'package:flutter/material.dart';

import 'package:thiran_task2/app/widgets/text.customized.dart';

import '../../../widgets/constants.dart';

class RepositoryTile extends StatelessWidget {
  final String repoName;
  final String avatarURL;
  final String ownerName;
  final String rating;
  final Function() ontap;

  const RepositoryTile({
    Key? key,
    required this.repoName,
    required this.ownerName,
    required this.rating,
    required this.ontap,
    required this.avatarURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: height * 0.16,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 233, 233).withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: height * 0.01),
        child: Row(
          children: [
            Container(
              height: height * 0.14,
              width: height * 0.15,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(avatarURL), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustomized(
                    text: repoName,
                    textSize: 22,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: "Owner : ",
                        style: TextStyle(
                          color: Colors.black45,
                        )),
                    TextSpan(
                        text: ownerName,
                        style: const TextStyle(color: Colors.amber))
                  ])),
                  TextCustomized(
                    text: "Stars count : $rating",
                    textSize: 16,
                    textColor: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
