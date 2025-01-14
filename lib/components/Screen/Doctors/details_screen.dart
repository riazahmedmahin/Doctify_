import 'package:app/components/Screen/Doctors/s2.dart';
import 'package:app/components/Screen/Doctors/schedule.dart';
import 'package:app/components/Screen/Doctors/ss.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorDetailsPage extends StatelessWidget {
  final String name;
  final String specialty;
  final String hospital;
  final String rating;
  final String image;
  final String description;
  final String qualification;
  final String experience;
  final String patient;
  final String fees;
  final String slot;

  const DoctorDetailsPage({
    Key? key,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.image,
    required this.description,
    required this.qualification,
    required this.experience,
    required this.patient,
    required this.fees, required this.slot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Details",style: TextStyle(fontSize: 20),),centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 224, 235, 251),
      ),
      backgroundColor: const Color.fromARGB(255, 224, 235, 251),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Image and Basic Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Image
                ClipOval(
                  child: Image.network(
                    image,
                    width: 70, // Adjust size as needed
                    height: 70, // Adjust size as needed
                    fit: BoxFit.fill,
                    // Ensures the image fills the circle
                  ),
                ),

                const SizedBox(width: 16), // Spacing between image and text
                // Name, Specialty, and Rating
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Rating in a Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Doctor Name
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              maxLines: 2, // Allow up to 2 lines for wrapping
                              overflow: TextOverflow
                                  .ellipsis, // Truncate if it exceeds 2 lines
                            ),
                          ),
                          const SizedBox(
                              width: 10), // Spacing between name and rating
                          // Rating Container
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Text(
                                  rating,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 18),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                          height: 4), // Spacing below name and rating
                      // Specialty and Hospital
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$specialty - $hospital",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          Text(
                            qualification,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stats Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoCard(title: "Patients", value: patient),
                const SizedBox(width: 15),
                _infoCard(title: "Experience", value: experience),
              ],
            ),
            const SizedBox(height: 20),

            // About Doctor
            _sectionTitle("About Doctor"),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 50),
            // Book Appointment Button
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 104, 179, 241), // Light blue
                      Color.fromARGB(255, 41, 121, 255)
                    ], // Two colors for the gradient
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => DoctorScheduleScreen(slot: slot,));
                    print('Book appointment with $name');
                  },
                  icon: Column(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: 17,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      const Icon(
                        Icons.monetization_on_sharp,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                  label: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Book Appointment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text(
                            "Fees: ",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            fees,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, // Make button background transparent
                    padding: const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 12),
                    shadowColor:
                        Colors.transparent, // Remove shadow if not needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blueGrey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}