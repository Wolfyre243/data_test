import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:data_test/components/event_components.dart';

class DataManager {

  // Getter to retrieve local file storage path
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Getter to retrive jsonFile
  static Future<File> getJSONFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  static Future<void> saveJson(String filename, List<dynamic> incomingData) async {
    // Map<String, dynamic>
    final file = await getJSONFile(filename);
    // Classes MUST have a toMap method to ease the conversion process
    final convertedArr = incomingData.map((item) => item.toMap());

    String jsonString = jsonEncode(convertedArr.toList());
    await file.writeAsString(jsonString);
  }

}

class EventDataManager {

  static Future<List<EventItem>> readJson() async {
    final file = await DataManager.getJSONFile('data.json');
      
    String contents = await file.readAsString();
    // Note that the jsonList has to contain more than 1 entity for it to work as a list.
    // Still trying to figure this out.
    List<dynamic> jsonList = jsonDecode(contents);
    return jsonList.map((json) => EventItem.fromJson(json)).toList();
  }

  static Future<void> addEvent(Map<String, dynamic> itemData) async {
    try {
      // Fetch the data from the file and store it in the _data list.
      final data = await readJson();

      itemData['id'] = data.length + 1;

      final newEvent = EventItem.fromJson(itemData);

      data.add(newEvent);
      DataManager.saveJson('data.json', data);

    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteEvent(int id) async {
    try {
      final data = await readJson();

      data.removeWhere((item) => item.id == id);
      DataManager.saveJson('data.json', data);
    } catch (e) {
      print(e);
    }
  }

}