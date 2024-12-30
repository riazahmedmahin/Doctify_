// lib/core/widgets/avatar.dart

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;

  const Avatar({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
