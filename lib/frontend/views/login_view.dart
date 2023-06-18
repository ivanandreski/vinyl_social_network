import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/api/user_service.dart';
import 'package:vinyl_social_network/domain/form_data/login_form_data.dart';
import 'package:vinyl_social_network/domain/view_model/collection_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/frontend/components/nav_drawer.dart';
import 'package:vinyl_social_network/frontend/views/collection_view.dart';
import 'package:vinyl_social_network/frontend/views/people_view.dart';

class LoginView extends StatefulWidget {
  static const title = "Login";
  static const route = '/login';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginFormKey = GlobalKey<FormState>();
  final loginFormData = LoginFormData();
  String errorMessage = "";

  void _submit(ProfileViewModel profileViewModel, CollectionViewModel collectionViewModel) async {
    final loginResponse = await profileViewModel.doLogin(loginFormData);
    if (loginResponse.success && mounted) {
      if(collectionViewModel.albums.isNotEmpty) {
        profileViewModel.syncCollection(collectionViewModel.albums);
      }

      Navigator.of(context).pop();
    } else {
      setState(() {
        errorMessage = loginResponse.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
    final collectionViewModel = context.watch<CollectionViewModel>();

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
                  if (errorMessage.isNotEmpty) ...[
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48)),
                        onPressed: () => _submit(profileViewModel, collectionViewModel),
                        child: const Text("Login")),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
