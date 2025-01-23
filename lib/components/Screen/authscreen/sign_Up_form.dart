import 'package:app/components/Firebase/firebase_service.dart';
import 'package:app/components/Screen/AuthScreen/userinfo_screen.dart';
import 'package:app/components/Screen/MainBottomNavScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _EmailController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();
  TextEditingController _PhoneController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _EmailController.dispose();
    _PasswordController.dispose();
    _PhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create an account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _EmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email address",
                      suffixIcon: Icon(Icons.mail, color: Colors.grey.shade400),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _PasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: Icon(Icons.lock, color: Colors.grey.shade400),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _PhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Phone number",
                      suffixIcon: Icon(Icons.phone, color: Colors.grey.shade400),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      if (value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _signup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 22, 108, 207),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 65, vertical: 17),
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
                              'Sign Up',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
void _signup() async {
  if (_formKey.currentState?.validate() == true) {
    setState(() {
      _isLoading = true;
    });

    String email = _EmailController.text.trim();
    String password = _PasswordController.text.trim();
    String phone = _PhoneController.text.trim(); // Assuming you have a phone input field

    try {
      User? user = await _auth.signupWithEmailAndPassword(email, password);
      setState(() {
        _isLoading = false;
      });

      if (user != null) {
        // Navigate to UserInfoScreen with email and phone
        Get.offAll(() => UserInfoScreen(email: email, phone: phone));
      } else {
        Get.snackbar("Error", "Sign up failed. Please try again.");
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
