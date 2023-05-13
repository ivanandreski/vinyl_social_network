import 'dart:convert';

import 'package:vinyl_social_network/domain/form_data/interface/form_data_interface.dart';

class LoginFormData implements FormDataInterface {
  String email = "";
  String password = "";

  @override
  String toJsonString() {
    return json.encode({
      "email": email,
      "password": password,
    });
  }
}
