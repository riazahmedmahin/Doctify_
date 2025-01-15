import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Initial data
  String name = "Riaz Ahmed Mahin";
  String email = "riaz@gmail.com";
  String phoneNumber = "581-553-199";
  String address = "Chittagong, Bangladesh";
  String password = "Ak47.1000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE0EBFB),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        backgroundColor: Color(0xFFE0EBFB),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture and name
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/71597653?v=4'), // Add your image here
            ),
            const SizedBox(height: 12),
            const Text(
              "Riaz Ahmed Mahin",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Editable fields
            buildEditableField(
              label: "Your name",
              value: name,
              icon: Icons.person,
              onChanged: (newValue) => setState(() => name = newValue),
            ),
            buildEditableField(
              label: "Your email address",
              value: email,
              icon: Icons.email,
              onChanged: (newValue) => setState(() => email = newValue),
            ),
            buildEditableField(
              label: "Your phone number",
              value: phoneNumber,
              icon: Icons.phone,
              onChanged: (newValue) => setState(() => phoneNumber = newValue),
            ),
            buildEditableField(
              label: "Your address",
              value: address,
              icon: Icons.location_on,
              onChanged: (newValue) => setState(() => address = newValue),
            ),
            buildEditableField(
              label: "Password",
              value: password,
              icon: Icons.visibility,
              isPassword: true,
              onChanged: (newValue) => setState(() => password = newValue),
            ),
            const SizedBox(height: 24),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Show a SnackBar as a placeholder for save logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Details saved successfully!"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 15,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField({
    required String label,
    required String value,
    required IconData icon,
    required ValueChanged<String> onChanged,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: value,
            obscureText: isPassword,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 243, 246, 246),
            ),
          ),
        ],
      ),
    );
  }
}

