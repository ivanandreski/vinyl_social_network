import 'package:flutter/material.dart';
import 'package:vinyl_social_network/api/auth_service.dart';
import 'package:vinyl_social_network/domain/form_data/login_form_data.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/repository/album_local_repository.dart';
import 'package:vinyl_social_network/repository/discogs_datasource.dart';
import 'package:vinyl_social_network/service/account_service.dart';
import 'package:vinyl_social_network/service/discogs_data_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final _authService = AuthService.instance;
  final _accountService = AccountService.instance;

  bool _loading = false;
  String? _token;

  bool get loading => _loading;
  String? get token => _token;

  ProfileViewModel() {
    getToken();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  getToken() async {
    String? token = await _accountService.getToken();
    setToken(token);
  }

  doLogin(LoginFormData loginFormData) async {
    // todo: finish this
    // _authService.doLogin(loginFormData);
  }
}
