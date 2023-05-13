import 'dart:convert';

import 'package:vinyl_social_network/domain/form_data/interface/form_data_interface.dart';

class RegisterFormData implements FormDataInterface {
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _password = "";
  String _passwordConfirmation = "";

  // Error messages
  String? _firstNameError = "The first name field is required";
  String? _lastNameError = "The last name field is required";
  String? _emailError = "The email field is required";
  String? _passwordError = "The password field is required";
  String? _confirmPasswordError = "The confirm password field is required";

  @override
  String toJsonString() {
    return json.encode({
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation
    });
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
    _firstName.isEmpty
        ? _firstNameError = "The first name field is required"
        : _firstNameError = null;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
    _lastName.isEmpty
        ? _lastNameError = "The last name field is required"
        : _lastNameError = null;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    _email.isEmpty
        ? _emailError = "The email field is required"
        : _emailError = null;

    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(_email)
        ? _emailError = "The email is invalid"
        : _emailError = null;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
    _password.isEmpty
        ? _passwordError = "The password field is required"
        : _passwordError = null;
  }

  String get passwordConfirmation => _passwordConfirmation;

  set passwordConfirmation(String value) {
    _passwordConfirmation = value;
    _passwordConfirmation.isEmpty
        ? _confirmPasswordError = "The password confirmation field is required"
        : _confirmPasswordError = null;

    _password != _passwordConfirmation
        ? _confirmPasswordError = "The password fields do not match"
        : _confirmPasswordError = null;
  }

  String? get confirmPasswordError => _confirmPasswordError;
  String? get passwordError => _passwordError;
  String? get emailError => _emailError;
  String? get lastNameError => _lastNameError;
  String? get firstNameError => _firstNameError;
}
