import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtil {
  static const String recentlyViewedKey = 'recentlyViewed';

  static Future<void> addToRecentlyViewed(int gameId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> recentlyViewedList = prefs
            .getStringList(recentlyViewedKey)
            ?.map((id) => int.parse(id))
            .toList() ??
        [];
    recentlyViewedList.insert(0, gameId);
    // Limit the list to a certain size, in this case 10
    recentlyViewedList = recentlyViewedList.take(10).toList();
    await prefs.setStringList(recentlyViewedKey,
        recentlyViewedList.map((id) => id.toString()).toList());
  }

  static Future<List<int>> getRecentlyViewed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recentlyViewedStringList =
        prefs.getStringList(recentlyViewedKey);
    return recentlyViewedStringList?.map((id) => int.parse(id)).toList() ?? [];
  }
}
