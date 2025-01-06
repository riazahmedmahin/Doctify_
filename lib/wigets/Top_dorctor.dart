import 'package:app/components/Screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopDoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String hospital;
  final String rating;
  final String image;

  const TopDoctorCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DoctorDetailsPage(
          name: name,
          specialty: specialty,
          hospital: hospital,
          rating: rating,
          image: image,
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(image),
                      radius: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Add ellipsis if the name is too long
                          ),
                          Row(
                            children: [
                              Text(
                                rating,
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.star, color: Colors.amber, size: 12),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  specialty,
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                Text(
                  hospital,
                  style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Positioned(
              bottom: 3,
              child: SizedBox(
                width: 80,
                height: 20,
                child: ElevatedButton(
                  onPressed: () {
                    print('Get Appointment for $name');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'Appointment',
                    style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
