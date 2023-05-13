import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vinyl_social_network/domain/form_data/login_form_data.dart';

class LoginView extends StatefulWidget {
  static const route = '/login';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginFormKey = GlobalKey<FormState>();
  final loginFormData = LoginFormData();
  String errorMessage = "";

  void _submit() async {
    // final authService = AuthService.instance;
    // final loginResponse = await authService.login(email, password);
    // if (loginResponse.success) {
    //   Navigator.pushReplacementNamed(context, PcBuilderScreen.routeName);
    // } else {
    //   setState(() {
    //     errorMessage = loginResponse.message;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(8),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: loginFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  if (errorMessage.isNotEmpty)
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
                      if (value == null || value.isEmpty) {
                        return 'Email field is required';
                      }
                      return "";
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    ],
                    onChanged: (val) {
                      setState(() {
                        loginFormData.email = val;
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
                      if (value == null || value.isEmpty) {
                        return 'Password field is required';
                      }

                      return "";
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    ],
                    onChanged: (val) {
                      setState(() {
                        loginFormData.password = val;
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48)),
                        onPressed: () => _submit(),
                        child: const Text("Login")),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
