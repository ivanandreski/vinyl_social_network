import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vinyl_social_network/app_config.dart';
import 'package:vinyl_social_network/domain/form_data/register_form_data.dart';
import 'package:vinyl_social_network/frontend/views/login_view.dart';

class RegisterView extends StatefulWidget {
  static const route = '/register';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final registerFormKey = GlobalKey<FormState>();
  final registerFormData = RegisterFormData();
  String firstNameError = "";

  void _submit() async {
    if (registerFormKey.currentState!.validate()) {
      final authService = AppConfig.of(context)!.authService;
      final registerResponse = await authService.doRegister(registerFormData);
      // TODO: moze da se desi duplicate email, handle!!!!!!!!!!
      if (registerResponse.success) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, LoginView.route);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(8),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: registerFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    obscureText: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "First Name",
                      border: OutlineInputBorder(),
                      errorMaxLines: 3,
                    ),
                    validator: (value) {
                      return registerFormData.firstNameError;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    ],
                    onChanged: (val) {
                      setState(() {
                        registerFormData.firstName = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Last Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return registerFormData.lastNameError;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    ],
                    onChanged: (val) {
                      setState(() {
                        registerFormData.lastName = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return registerFormData.emailError;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    ],
                    onChanged: (val) {
                      setState(() {
                        registerFormData.email = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return registerFormData.passwordError;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    ],
                    onChanged: (val) {
                      setState(() {
                        registerFormData.password = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return registerFormData.confirmPasswordError;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    ],
                    onChanged: (val) {
                      setState(() {
                        registerFormData.passwordConfirmation = val;
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48)),
                        onPressed: () => _submit(),
                        child: const Text("Register")),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
