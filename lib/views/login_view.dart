import 'package:donative/app/features/form_container_widget.dart';
import 'package:donative/app/features/toast.dart';
import 'package:donative/app/features/button_widget.dart';
import 'package:donative/app/user_auth/database_methods.dart';
import 'package:donative/app/user_auth/firebase_auth_services.dart';
import 'package:donative/views/screen.dart';
import 'package:donative/views/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
                      ButtonWidget(
                        onTap: () {
                          if (_loginKey.currentState!.validate()) {
                            _logIn();
                          } else {
                            showToast(
                                message: "Please fill all the required fields",
                                context: context);
                          }
                        },
                        buttonText: "Login",
                        toastMessage: null,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ButtonWidget(
                          onTap: () {
                            _signInWithGoogle();
                          },
                          buttonText: "Sign in with Google"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupView()),
                            );
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
        showToast(message: "Login Successful!", context: context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Screen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: "Invalid email or password", context: context);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        await FirebaseAuth.instance.signInWithCredential(credential);

        String? firstName = googleSignInAccount.displayName?.split(' ')[0];
        String? lastName = googleSignInAccount.displayName?.split(' ')[1];
        String? email = googleSignInAccount.email;
        String? profilePic = googleSignInAccount.photoUrl;

        Map<String, dynamic> usersData = {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "uid": FirebaseAuth.instance.currentUser!.uid,
          "dob": "",
          "address": "",
          "gender": "",
          "profilePic": profilePic,
          "donatedAmount": 0,
        };
        DatabaseMethods().addUsers(usersData);

        showToast(message: "Login Successful!", context: context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Screen()),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showToast(message: "An error occured!", context: context);
    }
  }
}
