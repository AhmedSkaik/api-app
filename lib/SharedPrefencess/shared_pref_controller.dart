import 'package:api_training/Models/Student.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Prefkeys { id, fullName, email, token, gender, isActive, loggedIn }

class SharedPrefController {
  static final SharedPrefController _instance = SharedPrefController._();

  SharedPrefController._();

  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initPrefancess() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required Student student}) async {
    await _sharedPreferences.setBool(Prefkeys.loggedIn.name, true);
    await _sharedPreferences.setInt(Prefkeys.id.name, student.id);
    await _sharedPreferences.setString(Prefkeys.email.name, student.email);
    await _sharedPreferences.setString(Prefkeys.fullName.name, student.fullName);
    await _sharedPreferences.setString(Prefkeys.token.name,'Bearer ${student.token}');
    await _sharedPreferences.setString(Prefkeys.gender.name, student.gender);
    await _sharedPreferences.setBool(Prefkeys.isActive.name, student.isActive);
  }

  bool get loggedIn =>
      _sharedPreferences.getBool(Prefkeys.loggedIn.name) ?? false;

  String get token => _sharedPreferences.getString(Prefkeys.token.name)?? ""  ;

  Future<bool> clear() async => _sharedPreferences.clear();
}
