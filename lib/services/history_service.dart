import 'dart:convert';
import 'package:coffe_brain/models/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  final SharedPreferences sharedPreferences;
  static const String key = 'history';

  HistoryService(this.sharedPreferences);

  Future<void> saveHistory(HistoryModel newHistory) async {
    List<HistoryModel> existingHistory = await getHistory();
    existingHistory.add(newHistory);
    final encodedHistory = json.encode(existingHistory);
    await sharedPreferences.setString(key, encodedHistory);
    print('succes');
  }

  Future<List<HistoryModel>> getHistory() async {
    final result = sharedPreferences.getString(key);
    if (result != null) {
      final decodedHistory = json.decode(result);
      if (decodedHistory is List) {
        return List<HistoryModel>.from(
          decodedHistory.map((item) => HistoryModel.fromJson(item)),
        );
      }
    }
    return [];
  }

  Future<void> deleteHistory() async {
    await sharedPreferences.remove(key);
  }
}
