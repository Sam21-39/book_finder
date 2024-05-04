import 'package:book_finder/core/ui/colors/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookCardPlaceholder extends StatelessWidget {
  const BookCardPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
            child: Shimmer.fromColors(
              baseColor: UIColors.backgroundColor,
              highlightColor: UIColors.secondaryColor,
              enabled: true,
              child: SizedBox(
                  width: width * 0.3,
                  height: height * 0.25,
                  child: Container(
                    color: UIColors.backgroundColor,
                  )),
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
                Shimmer.fromColors(
                  baseColor: UIColors.backgroundColor,
                  highlightColor: UIColors.secondaryColor,
                  enabled: true,
                  child: const Text(
                    "Name",
                    style: TextStyle(
                      color: UIColors.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Shimmer.fromColors(
                  baseColor: UIColors.backgroundColor,
                  highlightColor: UIColors.secondaryColor,
                  enabled: true,
                  child: const Text(
                    "Author",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: UIColors.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Shimmer.fromColors(
                  baseColor: UIColors.backgroundColor,
                  highlightColor: UIColors.secondaryColor,
                  enabled: true,
                  child: const Text(
                    "2024",
                    style: TextStyle(
                      color: UIColors.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                Shimmer.fromColors(
                  baseColor: UIColors.backgroundColor,
                  highlightColor: UIColors.secondaryColor,
                  enabled: true,
                  child: Container(
                    width: double.maxFinite,
                    height: height * 0.04,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: UIColors.textColor,
                        )),
                    alignment: Alignment.center,
                    child: const Text(
                      "Unread",
                      style: TextStyle(
                        color: UIColors.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
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
