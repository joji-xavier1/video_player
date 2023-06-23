import 'package:shared_preferences/shared_preferences.dart';

// save string vareiable in local storage
saveString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

// save bool vareiable in local storage
saveBool(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

// save int vareiable in local storage
saveint(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

// Read string vareiable from local storage
Future<String?> getStringValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? stringValue = prefs.getString(key);
  return stringValue;
}

// Read bool vareiable from local storage
Future<bool?> getboolValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  bool? value = prefs.getBool(key);
  return value;
}

// Read int vareiable from local storage
Future<int?> getIntValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  int? intValue = prefs.getInt(key);
  return intValue;
}

//clear all the keys stored in storage
clearStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
