import 'package:http/http.dart' as http;
import 'package:vinyl_social_network/domain/form_data/login_form_data.dart';
import 'package:vinyl_social_network/domain/form_data/register_form_data.dart';
import 'package:vinyl_social_network/domain/response/login_response.dart';
import 'package:vinyl_social_network/domain/response/register_response.dart';
import 'package:vinyl_social_network/utils/constants/general.dart';

class AuthService {
  static final AuthService _instance = AuthService._privateConstructor();

  AuthService._privateConstructor();

  static AuthService get instance => _instance;

  Future<LoginResponse> doLogin(LoginFormData loginFormData) {
    // TODO: implement doRegister
    throw UnimplementedError();
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
}
