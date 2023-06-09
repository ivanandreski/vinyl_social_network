import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vinyl_social_network/domain/form_data/login_form_data.dart';
import 'package:vinyl_social_network/domain/form_data/register_form_data.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/domain/models/user.dart';
import 'package:vinyl_social_network/domain/response/login_response.dart';
import 'package:vinyl_social_network/domain/response/register_response.dart';
import 'package:vinyl_social_network/service/account_service.dart';
import 'package:vinyl_social_network/utils/constants/general.dart';

class UserService {
  static final UserService _instance = UserService._privateConstructor();

  UserService._privateConstructor();

  static UserService get instance => _instance;

  Future<LoginResponse> doLogin(LoginFormData loginFormData) async {
    final url = Uri.parse('${Constants.apiUrl}/api/login');
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: loginFormData.toJsonString());
    if (response.statusCode == 200) {
      String token = json.decode(response.body)['token'] as String;
      return LoginResponse(message: "Success", success: true, token: token);
    } else {
      String message = json.decode(response.body)['message'] as String;
      return LoginResponse(success: false, message: message, token: 'null');
    }
  }

  Future<bool> doLogout(token) async {
    final url = Uri.parse('${Constants.apiUrl}/api/logout');
    final response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    });
    return (response.statusCode == 200);
  }

  Future<RegisterResponse> doRegister(RegisterFormData registerFormData) async {
    final url = Uri.parse('${Constants.apiUrl}/api/register');
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: registerFormData.toJsonString());
    if (response.statusCode == 201) {
      return RegisterResponse(message: "Success", success: true);
    } else {
      return RegisterResponse(success: false, message: "Something went wrong!");
    }
  }

  // todo: replace this with response when you finish it in the api
  Future<bool> syncCollection(List<Album> albums, String token) async {
    final url = Uri.parse('${Constants.apiUrl}/api/user/sync-collection');
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'albums': albums.map((e) => e.toJson()).toList()}));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> getMyProfile(String token) async {
    final url = Uri.parse('${Constants.apiUrl}/api/user');
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    });
    return json.decode(response.body);
  }

  Future<User> getUser(int userId) async {
    final token = await AccountService.instance.getToken();
    final url = Uri.parse('${Constants.apiUrl}/api/user/profile/$userId');
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    });
    return User.fromResponse(json.decode(response.body));
  }

  Future<List<dynamic>> searchUsers(String search) async {
    final token = await AccountService.instance.getToken();
    final url =
        Uri.parse('${Constants.apiUrl}/api/user/search-users?name=$search');
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      return [];
    }
  }

  toggleFollowPerson(int userId) async {
    final token = await AccountService.instance.getToken();
    final url = Uri.parse('${Constants.apiUrl}/api/user/toggle-follow/$userId');
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
  }

  updateProfileVisibility(String visibility, String token) async {
    final url =
        Uri.parse('${Constants.apiUrl}/api/user/change-profile-visibility');
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'visibility_type': visibility}));
    return json.decode(response.body);
  }
}
