import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinyl_social_network/service/interface/account_service_interface.dart';
import 'package:vinyl_social_network/utils/constants/shared_preferences_keys.dart';

class AccountService implements AccountServiceInterface {
  const AccountService() : super();

  @override
  Future<void> setDiscogsUsername(String discogsUsername) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        SharedPreferencesKeys.discogsUsername, discogsUsername);
  }

  @override
  Future<String?> getDiscogsUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(SharedPreferencesKeys.discogsUsername) as String;
  }

  @override
  Future<void> removeDiscogsUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesKeys.discogsUsername);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(SharedPreferencesKeys.token) as String;
  }

  @override
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesKeys.token);
  }

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesKeys.token, token);
  }
}
