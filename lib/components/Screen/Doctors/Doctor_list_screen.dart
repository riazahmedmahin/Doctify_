import 'package:app/components/Screen/Doctors/details_screen.dart';
import 'package:app/components/Screen/Doctors/s2.dart';
import 'package:app/components/Screen/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DoctorListScreen extends StatefulWidget {
  
  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  String selectedCategory = '';
  List<String> categories = [];
  List<Map<String, dynamic>> doctors = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchDoctors();
  }

  Future<void> fetchCategories() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        categories = querySnapshot.docs.map((doc) => doc['text'] as String).toList();
        if (categories.isNotEmpty) {
          selectedCategory = categories[0]; // Default to the first category
        }
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  Future<void> fetchDoctors() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('doctors').get();
      setState(() {
        doctors = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print("Error fetching doctors: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = doctors.where((doctor) => doctor['specialty'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE0EBFB),
      appBar: AppBar(
        title: const Text("Doctors"),
        backgroundColor: const Color.fromARGB(255, 224, 235, 251),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              children: categories.map((category) => _buildCategoryChip(category)).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => DoctorDetailsPage(
                          name: doctor['name'],
                          specialty: doctor['specialty'],
                          hospital: doctor['hospital'],
                          rating: doctor['rating'].toString(),
                          image: doctor['image'],
                          description: doctor['description'],
                          qualification: doctor['qualification'],
                          experience: doctor['experience'].toString(),
                          patient: doctor['patient'].toString(),
                          fees: doctor['fees'].toString(),
                          slot: doctor['slot'],
                        ));
                  },
                  child: _buildDoctorCard(
                    name: doctor['name'] ?? 'N/A',
                    qualification: doctor['qualification'] ?? 'N/A',
                    specialty: doctor['specialty'] ?? 'N/A',
                    imagePath: doctor['image'] ?? 'https://via.placeholder.com/150',
                    rating: doctor['rating']?.toString() ?? 'N/A',
                    fees: doctor['fees']?.toString() ?? 'N/A',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

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
            selectedCategory = selected ? category : selectedCategory;
          });
        },
      ),
    );
  }

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.fill,
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
                  'Fees: $fees',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => Payment(fees: fees));
                  },
                  child: const Text('Book Now', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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
