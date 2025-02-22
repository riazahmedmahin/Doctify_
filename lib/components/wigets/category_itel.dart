import 'package:flutter/material.dart';
class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.image,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String image;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 187, 216, 250),
                  Color.fromARGB(255, 224, 235, 249),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12), // Boxy appearance
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Match border radius
                child: Image.network(
                  image,
                  width: 50, // Set a smaller width for the image
                  height: 50, // Set a smaller height for the image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8), // Spacing between the image and text
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}