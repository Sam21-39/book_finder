import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityCheck extends GetxController {
  final isConnected = true.obs;
  final Connectivity connectivity = Connectivity();

  init() async {
    connectivity.onConnectivityChanged.listen((event) {
      if (event.contains(ConnectivityResult.mobile) ||
          event.contains(ConnectivityResult.wifi)) {
        isConnected.value = true;
      } else {
        isConnected.value = false;
      }
    });
  }
}
