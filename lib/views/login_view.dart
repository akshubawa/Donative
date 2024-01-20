import 'package:donative/app/features/form_container_widget.dart';
import 'package:donative/app/user_auth/firebase_auth_services.dart';
import 'package:donative/views/home_view.dart';
import 'package:donative/views/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _loginKey = GlobalKey<FormState>();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isLoading = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? validateInputBox(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Form(
                key: _loginKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FormContainerWidget(
                          labelText: "Email Address",
                          controller: _emailController,
                          textInputType: TextInputType.emailAddress,
                          isPasswordField: false,
                          validateInputBox: validateInputBox),
                      const SizedBox(
                        height: 15,
                      ),
                      FormContainerWidget(
                          labelText: "Password",
                          controller: _passwordController,
                          isPasswordField: true,
                          validateInputBox: validateInputBox),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          _logIn();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          child: Center(
                            child: Text("Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            if (_loginKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupView()),
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please fill all the required fields",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            }
                          },
                          child: const Text("New User? Sign Up")),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _logIn() async {
    setState(() {
      _isLoading = true;
    });

    String? email = _emailController.text;
    String? password = _passwordController.text;
    try {
      User? user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        Fluttertoast.showToast(
            msg: "Login Successful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Some error occured!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
