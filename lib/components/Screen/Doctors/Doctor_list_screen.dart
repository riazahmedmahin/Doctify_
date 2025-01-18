import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorListScreen extends StatefulWidget {
  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  String selectedCategory = 'Neurologist'; // Set initial category to Cardio
  List<Map<String, dynamic>> doctors = [];

  // List of available categories
  final List<String> categories = [
    'Neurologist',
    'Cardiologist',
    'Dentist',
    'Hepatology',
    'Family Physician',
    'Internist',
    'Pediatrician',
    'Dermatologist',
  ];

  @override
  void initState() {
    super.initState();
    fetchDoctors(); // Fetch doctors data when the screen initializes
  }

  Future<void> fetchDoctors() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('doctors').get();
      setState(() {
        doctors = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      // Handle errors
      print("Error fetching doctors: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter doctors based on selected category
    final filteredDoctors = doctors.where((doctor) => doctor['specialty'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE0EBFB), // Light background color
      appBar: AppBar(
        title: const Text("Doctors"),
        backgroundColor: const Color.fromARGB(255, 224, 235, 251),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 12, bottom: 7, right: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 15,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              children: categories.map((category) => _buildCategoryChip(category)).toList(),
            ),
          ),
          // Doctor List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return _buildDoctorCard(
                  name: doctor['name'] ?? 'N/A',
                  qualification: doctor['qualification'] ?? 'N/A',
                  specialty: doctor['specialty'] ?? 'N/A',
                  imagePath: doctor['image'] ?? 'https://via.placeholder.com/150', // Default image
                  rating: doctor['rating']?.toString() ?? 'N/A',
                  fees: doctor['fees']?.toString() ?? 'N/A',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build category chips
  Widget _buildCategoryChip(String category) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(category),
        labelStyle: TextStyle(
          color: selectedCategory == category ? Colors.white : Colors.black,
        ),
        selectedColor: Colors.blueAccent,
        backgroundColor: Colors.grey.shade200,
        selected: selectedCategory == category,
        onSelected: (bool selected) {
          setState(() {
            selectedCategory = selected ? category : selectedCategory; // Update category
          });
        },
      ),
    );
  }

  // Helper method to build each doctor card
  Widget _buildDoctorCard({
    required String name,
    required String qualification,
    required String specialty,
    required String imagePath,
    required String rating,
    required String fees,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
                      child: Image.network(
                        imagePath,
                        width: 50, // Adjust the size
                        height: 50, // Adjust the size
                        fit: BoxFit.fill, // Ensures the image covers the circle area
                      ),
                    ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    qualification,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    specialty,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Fees $fees',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement booking functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$name has been booked!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 22, 108, 207),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Book Now', style: TextStyle(fontSize: 12,color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
