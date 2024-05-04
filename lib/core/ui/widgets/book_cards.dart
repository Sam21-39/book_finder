import 'package:book_finder/core/services/db/local_db.dart';
import 'package:book_finder/core/ui/colors/ui_colors.dart';
import 'package:book_finder/features/home/model/book_list_model.dart';
import 'package:book_finder/features/home/viewModel/home_data_ctrl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookCard extends StatelessWidget {
  final ReadingLogEntry? entry;
  BookCard({super.key, this.entry});
  final HomeDataCtrl homeDataCtrl = Get.put(HomeDataCtrl());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Future.delayed(Duration.zero).then((value) {
      homeDataCtrl.init();
    });
    return Container(
      width: double.maxFinite,
      height: height * 0.25,
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: UIColors.primaryColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(0, 2),
            spreadRadius: 2,
            color: UIColors.textColor.withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: width * 0.3,
              height: height * 0.25,
              child: entry!.work!.coverId != null
                  ? FadeInImage(
                      placeholder: const AssetImage(
                        "assets/images/book.jpg",
                      ),
                      image: NetworkImage(
                        "https://covers.openlibrary.org/b/id/${entry!.work!.coverId ?? 0}-M.jpg",
                      ),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/images/book.jpg",
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry!.work!.title ?? "",
                          style: const TextStyle(
                            color: UIColors.textColor,
                            fontSize: 20,
                            fontFamily: 'NotoSerif',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          entry!.work!.authorNames != null
                              ? entry!.work!.authorNames!.join(', ')
                              : "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: UIColors.textColor,
                            fontSize: 15,
                            fontFamily: 'NotoSerif',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${entry!.work!.firstPublishYear ?? ""}',
                          style: const TextStyle(
                            color: UIColors.textColor,
                            fontSize: 15,
                            fontFamily: 'NotoSerif',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                Obx(
                  () => InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      if (entry!.work!.key != "NA") {
                        if (homeDataCtrl.readlist.contains(entry!.work!.key)) {
                          homeDataCtrl.readlist.remove(entry!.work!.key!);
                        } else {
                          homeDataCtrl.readlist.add(entry!.work!.key!);
                        }
                        LocalDB.setReadList(homeDataCtrl.readlist
                            .map((element) => element.toString())
                            .toList());
                      }
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: height * 0.04,
                      decoration: BoxDecoration(
                          color:
                              homeDataCtrl.readlist.contains(entry!.work!.key)
                                  ? UIColors.successColor
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                homeDataCtrl.readlist.contains(entry!.work!.key)
                                    ? Colors.transparent
                                    : UIColors.textColor,
                          )),
                      alignment: Alignment.center,
                      child: Text(
                        homeDataCtrl.readlist.contains(entry!.work!.key)
                            ? "Read"
                            : "Unread",
                        style: TextStyle(
                          color:
                              homeDataCtrl.readlist.contains(entry!.work!.key)
                                  ? UIColors.backgroundColor
                                  : UIColors.textColor,
                          fontSize: 15,
                          fontFamily: 'NotoSerif',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
