import 'package:vinyl_social_network/domain/response/response_interface.dart';

class LoginResponse extends ResponseInterface {
  late final String token;

  LoginResponse(
      {required this.token, required String message, required bool success})
      : super(message: message, success: success);
}
