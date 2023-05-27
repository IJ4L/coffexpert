import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  final SharedPreferences sharedPreferences;

  HistoryService(this.sharedPreferences);

  Future<void> saveHistory(List<Map<String, dynamic>> history) async {
    final encodedHistory = json.encode(history);
    await sharedPreferences.setString('history', encodedHistory);
  }

  Future<List<Map<String, List<String>>>> getHistory() async {
    final result = sharedPreferences.getString('history');
    if (result != null) {
      final decodedHistory = json.decode(result);
      if (decodedHistory is List) {
        return List<Map<String, List<String>>>.from(decodedHistory.map(
          (item) => Map<String, List<String>>.from(item.map(
            (key, value) => MapEntry(key, List<String>.from(value)),
          )),
        ));
      }
    }
    return [];
  }

  Future<void> deleteHistory() async {
    await sharedPreferences.remove('history');
  }
}
