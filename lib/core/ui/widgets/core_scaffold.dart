import 'package:book_finder/core/services/connection/connection_checker.dart';
import 'package:book_finder/core/ui/colors/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoreScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;

  CoreScaffold({
    super.key,
    required this.body,
    this.appBar,
  });

  final conn = Get.put(ConnectivityCheck());

  @override
  Widget build(BuildContext context) {
    conn.init();
    return Scaffold(
      appBar: appBar,
      backgroundColor: UIColors.backgroundColor,
      body: Obx(
        () => conn.isConnected.value
            ? body
            : const Center(
                child: Text('No Internet Connection!'),
              ),
      ),
    );
  }
}
