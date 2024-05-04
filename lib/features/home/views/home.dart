import 'package:book_finder/core/ui/colors/ui_colors.dart';
import 'package:book_finder/core/ui/widgets/book_cards.dart';
import 'package:book_finder/core/ui/widgets/book_cards_placeholder.dart';
import 'package:book_finder/core/ui/widgets/core_scaffold.dart';
import 'package:book_finder/features/home/viewModel/home_data_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeDataCtrl homeDataCtrl = Get.put(HomeDataCtrl());
  final searchController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Future.delayed(Duration.zero).then((value) {
      // searchController.addListener(() {
      if (searchController.text.isEmpty) {
        homeDataCtrl.getBookList();
      }
      // });
    });
    return CoreScaffold(
        body: SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 32,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text(
              "Welcome to BookFinder",
              style: TextStyle(
                color: UIColors.textColor,
                fontSize: 24,
                fontFamily: 'NotoSerif',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.maxFinite,
            height: height * 0.06,
            margin: const EdgeInsets.only(left: 16, right: 16),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: UIColors.backgroundColor,
              border: Border.all(color: UIColors.secondaryColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search books by title...",
                    ),
                    // onSubmitted: (value) {
                    //   if (searchController.text.isNotEmpty) {
                    //     homeDataCtrl.search(searchController.text.trim());
                    //   } else {
                    //     homeDataCtrl.getBookList();
                    //   }
                    // },
                    style: const TextStyle(
                      color: UIColors.textColor,
                      fontSize: 16,
                      fontFamily: 'NotoSerif',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    if (searchController.text.isNotEmpty) {
                      homeDataCtrl.search(searchController.text.trim());
                    }
                  },
                  child: const Icon(
                    Icons.search,
                    color: UIColors.secondaryColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => Visibility(
              visible: homeDataCtrl.bookList.isNotEmpty,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: homeDataCtrl.bookList
                        .map((element) => BookCard(
                              entry: element,
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
                visible: homeDataCtrl.bookList.isEmpty,
                child: Expanded(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) => const BookCardPlaceholder(),
                ))),
          )
        ],
      ),
    ));
  }
}
