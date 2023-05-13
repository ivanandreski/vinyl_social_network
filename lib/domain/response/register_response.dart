import 'package:vinyl_social_network/domain/response/response_interface.dart';

class RegisterResponse extends ResponseInterface {
  RegisterResponse({required String message, required bool success})
      : super(message: message, success: success);
}
