import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreExample extends StatelessWidget {
  final CollectionReference products = FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firestore Example")),
      body: StreamBuilder(
        stream: products.snapshots(), // Fetch data in real-time
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          final productData = snapshot.data!.docs;
          return ListView.builder(
            itemCount: productData.length,
            itemBuilder: (context, index) {
              var product = productData[index];
              return ListTile(
                title: Text(product['name']),
                subtitle: Text("\$${product['price']}"),
              );
            },
          );
        },
      ),
    );
  }
}
