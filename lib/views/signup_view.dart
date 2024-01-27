import 'package:donative/app/features/form_container_widget.dart';
import 'package:donative/app/features/toast.dart';
import 'package:donative/app/features/button_widget.dart';
import 'package:donative/app/user_auth/database_methods.dart';
import 'package:donative/app/user_auth/firebase_auth_services.dart';
import 'package:donative/views/login_view.dart';
import 'package:donative/views/screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _signupKey = GlobalKey<FormState>();

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  uploadUsersData() async {
    Map<String, dynamic> usersData = {
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "phone": _phoneController.text,
      "email": _emailController.text,
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "dob": "",
      "address": "",
      "gender": "",
      "profilePic": "",
      "donatedAmount": 0,
    };
    DatabaseMethods().addUsers(usersData);
  }

  bool _isLoading = false;
  final FirebaseAuthService _auth = FirebaseAuthService();

  String? validateInputBox(String? value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Form(
                key: _signupKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "SIGN UP",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FormContainerWidget(
                                labelText: "First Name",
                                controller: _firstNameController,
                                isPasswordField: false,
                                textInputType: TextInputType.name,
                                validateInputBox: validateInputBox),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: FormContainerWidget(
                                labelText: "Last Name",
                                controller: _lastNameController,
                                isPasswordField: false,
                                textInputType: TextInputType.name,
                                validateInputBox: validateInputBox),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FormContainerWidget(
                          labelText: "Mobile Number",
                          controller: _phoneController,
                          isPasswordField: false,
                          textInputType: TextInputType.phone,
                          validateInputBox: validateInputBox),
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
                      FormContainerWidget(
                          labelText: "Confirm Password",
                          controller: _confirmPasswordController,
                          isPasswordField: true,
                          validateInputBox: validateInputBox),
                      const SizedBox(
                        height: 15,
                      ),
                      ButtonWidget(
                          onTap: () {
                            if (_signupKey.currentState!.validate()) {
                              _signUp();
                            } else {
                              showToast(
                                  message:
                                      "Please fill all the required fields",
                                  context: context);
                            }
                          },
                          buttonText: "Sign Up",
                          toastMessage: null),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            );
                          },
                          child: const Text("Existing User? Login")),
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

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    String? email = _emailController.text;
    String? password = _passwordController.text;
    String? confirmPassword = _confirmPasswordController.text;
    if (password == confirmPassword) {
      try {
        User? user = await _auth.signUpWithEmailAndPassword(
            email: email, password: password);

        if (user != null) {
          uploadUsersData();
          setState(() {
            _isLoading = true;
          });
          showToast(message: "Account created successfully.", context: context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Screen()),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: "Email already in use",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              textColor: Theme.of(context).colorScheme.primary,
              fontSize: 16.0);
        }
      } catch (e) {
        showToast(message: "Some error occured!", context: context);
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      showToast(message: "Password does not match", context: context);
      setState(() {
        _isLoading = false;
      });
    }
  }
}
