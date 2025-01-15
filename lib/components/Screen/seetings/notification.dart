import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // State variables to control the switches
  bool isNotificationsEnabled = true;
  bool isMessageOptionEnabled = false;
  bool isVideoCallOptionEnabled = false;
  bool isCallOptionEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 235, 251), // Light blue background
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildSettingsOption(
            icon: Icons.notifications,
            label: 'Notifications',
            value: isNotificationsEnabled,
            onChanged: (newValue) {
              setState(() {
                isNotificationsEnabled = newValue;
              });
            },
          ),
          _buildSettingsOption(
            icon: Icons.message,
            label: 'Message Option',
            value: isMessageOptionEnabled,
            onChanged: (newValue) {
              setState(() {
                isMessageOptionEnabled = newValue;
              });
            },
          ),
          _buildSettingsOption(
            icon: Icons.video_call,
            label: 'Video Call Option',
            value: isVideoCallOptionEnabled,
            onChanged: (newValue) {
              setState(() {
                isVideoCallOptionEnabled = newValue;
              });
            },
          ),
          _buildSettingsOption(
            icon: Icons.call,
            label: 'Call Option', // Fixed typo
            value: isCallOptionEnabled,
            onChanged: (newValue) {
              setState(() {
                isCallOptionEnabled = newValue;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.purple),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged, // Call the onChanged callback
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

