import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String _name = "User";
  int _decimalPlaces = 4;

  String get name => _name;
  int get decimalPlaces => _decimalPlaces;

  void setName(String name) async {
    _name = name;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
    notifyListeners();
  }

  void setDecimalPlaces(int decimalPlaces) async {
    _decimalPlaces = decimalPlaces;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("decimalPlaces", decimalPlaces);
    notifyListeners();
  }

  Future<void> getState() async {
    // get name from shared preferences
    // notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name") ?? "User";
    _decimalPlaces = prefs.getInt("decimalPlaces") ?? 4;
    notifyListeners();
  }
}
