import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinyl_social_network/utils/constants/shared_preferences_keys.dart';

class AccountService {
  static final AccountService _instance = AccountService._privateConstructor();

  AccountService._privateConstructor();

  static AccountService get instance => _instance;

  Future<void> setDiscogsUsername(String discogsUsername) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        SharedPreferencesKeys.discogsUsername, discogsUsername);
  }

  Future<String?> getDiscogsUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(SharedPreferencesKeys.discogsUsername) as String;
  }

  Future<void> removeDiscogsUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesKeys.discogsUsername);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(SharedPreferencesKeys.token) as String;
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesKeys.token);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesKeys.token, token);
  }
}
