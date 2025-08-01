import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  static Future<void> addPhoto(File file, String taskId) async {
    await Supabase.instance.client.storage.from("media").upload("$taskId", file);
  }

  static Future<List<Map<String, dynamic>>> getTasksImages() async {
    List<Map<String, dynamic>> returnList = [];
    var resultado = await Supabase.instance.client.storage.from("media").list();
    for (var a in resultado) {
      returnList.add({"taskId": a.name, "mediaType": a.metadata!["mimetype"]});
    }
    return returnList;
  }

  static Future<String> getTaskImage(String taskId) async {
    return await Supabase.instance.client.storage.from("media").getPublicUrl(taskId);
  }
}
