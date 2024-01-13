import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<void> saveEquation(String eq) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? a = await loadSavedEquations();
    if (a != null) {
      a.add(eq);
    } else {
      a = [eq];
    }
    await prefs.setStringList('saved_equations', a);
  }

  static Future<List<String>?> loadSavedEquations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedEquations = prefs.getStringList('saved_equations');
    return savedEquations ?? [];
  }

  static Future<void> saveResult(String res) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? b = await loadSavedResults();
    if (b != null) {
      b.add(res);
    } else {
      b = [res];
    }
    await prefs.setStringList('saved_results', b);
  }

  static Future<List<String>?> loadSavedResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedResults = prefs.getStringList('saved_results');
    return savedResults ?? [];
  }

  static Future<void> clearSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear(); 
}
}
