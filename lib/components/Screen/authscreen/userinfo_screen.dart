import 'package:app/components/Screen/MainBottomNavScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoScreen extends StatefulWidget {
  final String email;
  final String phone;

  const UserInfoScreen({Key? key, required this.email, required this.phone})
      : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveUserInfo() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseFirestore.instance
            .collection('userinfo')
            .doc(widget.email)
            .set({
          'email': widget.email,
          'name': _nameController.text.trim(),
          'phone': widget.phone,
          'address': _addressController.text.trim(),
        });

        setState(() {
          _isLoading = false;
        });

        Get.offAll(
            () => MainBottomNavScreen()); // Navigate to MainBottomNavScreen
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar("Error", e.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 235, 251),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("Join Us",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
                Text("Please fillup your information",style: TextStyle(fontSize: 15),),
                SizedBox(height: 30,),
                TextFormField(
                  initialValue:widget.email,
                  decoration: InputDecoration(
                     fillColor: Colors.blueAccent,
                    labelText: "Email",
                    border: OutlineInputBorder(
                      
                    )
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    fillColor: Colors.blueAccent,
                      labelText: "Name", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: widget.phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: "Phone Number", 
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                      labelText: "Address", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveUserInfo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isLoading ? Colors.grey : Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 165, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(6), // Circular border radius
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
