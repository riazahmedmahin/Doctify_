import 'package:flutter/material.dart';


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
    return Container(
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
                    radius: 20, // Image on the side, slightly larger for visibility
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),
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
                ],
              ),
              SizedBox(height: 6), // Space between sections
              Text(
                specialty,
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              //SizedBox(height: 4),
              Text(
                hospital,
                style: TextStyle(fontSize: 11, color: Colors.black,fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Positioned(
            bottom: 3,
            //left: 5,
            child: SizedBox(
              width: 80, // Smaller width for a compact button
              height: 20, // Smaller height
              child: ElevatedButton(
                onPressed: () {
                  // Handle appointment button tap
                  print('Get Appointment for $name');
                },
                style: ElevatedButton.styleFrom(
                  //primary: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3), // Rounded corners for the button
                  ),
                  padding: EdgeInsets.zero, // Compact padding
                ),
                child: Text(
                  'Appointment',
                  style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
