import 'package:vinyl_social_network/domain/form_data/login_form_data.dart';
import 'package:vinyl_social_network/domain/form_data/register_form_data.dart';
import 'package:vinyl_social_network/domain/response/login_response.dart';
import 'package:vinyl_social_network/domain/response/register_response.dart';

abstract class AuthServiceInterface {
  Future<LoginResponse> doLogin(LoginFormData loginFormData);
  Future<RegisterResponse> doRegister(RegisterFormData registerFormData);
}
