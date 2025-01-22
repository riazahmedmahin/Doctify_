import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  final String userEmail;

  const ProfileScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User Data Variables
  String userId = '';
  String name = '';
  String email = '';
  String phoneNumber = '';
  String address = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    email = widget.userEmail; // Auto-fill signed-in email
    fetchProfileData(); // Fetch profile data at initialization
  }

  // Fetch user profile data from Firebase
  Future<void> fetchProfileData() async {
    try {
      // Check if the user document already exists
      QuerySnapshot querySnapshot = await _firestore
          .collection('profiles')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If user exists, fetch their data
        final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          userId = data['userId'] ?? '';
          name = data['name'] ?? '';
          phoneNumber = data['phoneNumber'] ?? '';
          address = data['address'] ?? '';
          password = data['password'] ?? '';
        });
      } else {
        // If user does not exist, generate a new user ID
        userId = generateUniqueUserId(email);
      }
    } catch (e) {
      print("Error fetching profile data: $e");
    }
  }

  // Save or update user data in Firebase
  Future<void> saveProfileData() async {
    try {
      await _firestore.collection('profiles').doc(userId).set({
        'userId': userId,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'password': password,
      });
      fetchProfileData(); // Refresh UI with updated data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile saved successfully!"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving profile: $e"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Generate a unique user ID based on email (only once)
  String generateUniqueUserId(String email) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${email.split('@')[0]}_$timestamp';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0EBFB),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
        backgroundColor: const Color(0xFFE0EBFB),
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
                  'https://avatars.githubusercontent.com/u/71597653?v=4'),
            ),
            const SizedBox(height: 12),
            Text(
              name.isEmpty ? 'Your Name' : name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // User ID field
            buildNonEditableField(label: "User ID", value: userId),

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
                onPressed: saveProfileData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 22, 108, 207),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 15, color: Colors.white),
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

  Widget buildNonEditableField({
    required String label,
    required String value,
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
            enabled: false,
            decoration: InputDecoration(
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
