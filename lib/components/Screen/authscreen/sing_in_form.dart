import 'package:app/components/Screen/authscreen/forgetpass_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Firebase/firebase_service.dart';
import '../MainBottomNavScreen.dart';

class SigninForm extends StatefulWidget {
  final PageController pageController;

  SigninForm({Key? key, required this.pageController, required void Function() onCreateAccount}) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  bool _isLoading = false; // Loading state

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Email address",
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  suffixIcon: Icon(
                    Icons.mail,
                    color: Colors.grey.shade400,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Email regex for validation
                  String pattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null; // Valid email
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  suffixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey.shade400,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null; // Valid password
                },
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.to(ForgotPasswordScreen());
                  },
                  child: Text("Forget Password?"),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 65, vertical: 17),
                    ),
                    child: _isLoading
                        ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      'Sign In',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey.shade300),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.pageController.animateToPage(2,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease);
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(color: Color.fromARGB(255, 107, 95, 183)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    if (_formKey.currentState?.validate() == true) { // Validate the form
      setState(() {
        _isLoading = true;
      });

      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      try {
        User? user = await _auth.signInWithEmailAndPassword(email, password);
        setState(() {
          _isLoading = false;
        });

        if (user != null) {
          Get.to(MainBottomNavScreen());
        } else {
          print("Sign in failed.");
          Get.snackbar("Error", "Sign in failed. Please check your credentials.");
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar("Error", e.toString());
      }
    }
  }
}
