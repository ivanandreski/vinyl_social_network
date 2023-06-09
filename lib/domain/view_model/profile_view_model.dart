import 'package:flutter/material.dart';
import 'package:vinyl_social_network/api/user_service.dart';
import 'package:vinyl_social_network/domain/form_data/login_form_data.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/domain/models/user.dart';
import 'package:vinyl_social_network/domain/response/login_response.dart';
import 'package:vinyl_social_network/service/account_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final _userService = UserService.instance;
  final _accountService = AccountService.instance;

  bool _loading = false;
  String? _token;
  String? _discogsUsername;
  User? _user;

  bool get loading => _loading;
  String? get token => _token;
  String? get discogsUsername => _discogsUsername;
  User? get user => _user;

  ProfileViewModel() {
    getToken();
    getDiscogsUsername();
  }
// todo: tidy functions
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  setUser(User user) {
    _user = user;
    notifyListeners();
  }

  setDiscogsUsername(String? discogsUsername) {
    _discogsUsername = discogsUsername;
    notifyListeners();
  }

  getToken() async {
    String? token = await _accountService.getToken();
    setToken(token);
    await getUser();
  }

  getDiscogsUsername() async {
    String? discogsUsername = await _accountService.getDiscogsUsername();
    setDiscogsUsername(discogsUsername);
  }

  Future<LoginResponse> doLogin(LoginFormData loginFormData) async {
    final response = await _userService.doLogin(loginFormData);
    if(response.success) {
      await _accountService.setToken(response.token);
      setToken(response.token);
      getUser();
    }

    notifyListeners();

    return response;
  }

  Future<bool> doLogout() async {
    final response = await _userService.doLogout(_token);
    if(response) {
      await _accountService.removeToken();
      setToken(null);
    }

    notifyListeners();

    return response;
  }

  changeDiscogsUsername(String discogsUsername) async {
    await _accountService.setDiscogsUsername(discogsUsername);
    setDiscogsUsername(discogsUsername);
  }

  Future<bool> syncCollection(List<Album> albums) async {
    return await _userService.syncCollection(albums, _token!);
  }

  clearDiscogs() async {
    await _accountService.removeDiscogsUsername();
    setDiscogsUsername(null);
  }

  getUser() async {
    if(token != null) {
      final response = await _userService.getMyProfile(token!);

      final user = User.fromResponse(response);
      setUser(user);
    }
  }

  updateProfileVisibility(String? visibility) async {
    if(visibility != null) {
      final response = await _userService.updateProfileVisibility(visibility, _token!);
      setUser(User.fromResponse(response));
    }
  }
}
