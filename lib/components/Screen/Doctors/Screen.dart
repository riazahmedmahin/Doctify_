import 'package:app/components/Screen/Doctors/details_screen.dart';
import 'package:app/components/Screen/PaymentScreen/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Screen extends StatelessWidget {
  final String category;

  const Screen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 235, 251),
      appBar: AppBar(title: Text('Doctors in $category'),backgroundColor: Color.fromARGB(255, 224, 235, 251),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('doctors') // Collection for doctors
            .where('specialty', isEqualTo: category)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var doctors = snapshot.data!.docs;
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              var doctor = doctors[index];
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
                    experience: doctor['experience'],
                    patient: doctor['patient'],
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
          );
        },
      ),
    );
  }
}
////
  Widget _buildDoctorCard({
    required String name,
    required String qualification,
    required String specialty,
    required String imagePath,
    required String rating,
    required String fees,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
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
