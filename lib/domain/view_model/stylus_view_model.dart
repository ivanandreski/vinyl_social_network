import 'package:flutter/material.dart';
import 'package:vinyl_social_network/api/stylus_service.dart';
import 'package:vinyl_social_network/domain/models/stylus.dart';
import 'package:vinyl_social_network/service/account_service.dart';

class StylusViewModel extends ChangeNotifier {
  final _stylusService = StylusService.instance;
  final _accountService = AccountService.instance;

  bool _loading = true;
  List<Stylus> _styluses = [];

  List<Stylus> get styluses => _styluses;
  List<Stylus> get activeStyluses => _styluses.where((s) => !s.isRetired).toList();
  List<Stylus> get retiredStyluses => _styluses.where((s) => s.isRetired).toList();

  bool get loading => _loading;

  StylusViewModel() {
    getStyluses();
  }

  setStyluses(List<Stylus> value) {
    _styluses = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  getStyluses() async {
    // todo: check for internet connection
    // if not available fech from cache isar and display message that yu can view them but edits and ads ill not be saved
    final token = await _accountService.getToken();
    if(token == null) return;

    setLoading(true);
    setStyluses(await _stylusService.getStyluses(token: token));
    setLoading(false);
  }

  createStylus(String stylusName) async {
    final token = await _accountService.getToken();
    if(token == null) return;

    await _stylusService.createStylus(stylusName: stylusName, token: token);
    await getStyluses();
    notifyListeners();
  }

  retireStylus(int stylusId) async {
    final token = await _accountService.getToken();
    if(token == null) return;

    await _stylusService.retireStylus(stylusId: stylusId, token: token);
    await getStyluses();
    notifyListeners();
  }

  deleteStylus(int stylusId) async {
    final token = await _accountService.getToken();
    if(token == null) return;

    await _stylusService.deleteStylus(stylusId: stylusId, token: token);
    await getStyluses();
    notifyListeners();
  }
}