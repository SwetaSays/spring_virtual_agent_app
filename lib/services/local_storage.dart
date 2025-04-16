import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/message_model.dart';

class LocalStorageService {
  static const _key = 'messages';

  static Future<void> saveMessages(List<Message> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final list = messages.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList(_key, list);
  }

  static Future<List<Message>> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.map((str) => Message.fromJson(jsonDecode(str))).toList();
  }
}
