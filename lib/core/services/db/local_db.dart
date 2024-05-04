import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static getReadList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(SPKeys.readKey);
  }

  static setReadList(List<String> list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(SPKeys.readKey, list);
  }
}

class SPKeys {
  static const readKey = "_readListKey";
}
