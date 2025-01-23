import 'package:app/components/Screen/Doctors/categorlist_screen.dart';
import 'package:app/components/wigets/Top_dorctor.dart';
import 'package:app/components/wigets/UpcommingCard.dart';
import 'package:app/components/wigets/category_itel.dart';
import 'package:app/components/Screen/Doctors/Screen.dart';
import 'package:app/components/wigets/searchbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 235, 251),
      appBar: Appbar,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Find your medicine\nspecialist",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 29),
              ),
              SizedBox(height: 10),
              TextFieldWithSortIcon(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Doctor specialist",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>AllDoctorCategories());
                    },
                    child: Text(
                      "see all",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 22, 108, 207),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              CategoryItemList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upcomming",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "see all",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color.fromARGB(255, 22, 108, 207),
                    ),
                  )
                ],
              ),

              SizedBox(height: 5),
              Upcommingcard(),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Doctors",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "see all",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color.fromARGB(255, 22, 108, 207),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              TopDoctorsList(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar get Appbar {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 224, 235, 251),
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 5, right: 8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(

            Icons.menu_open,
            size: 20,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8, top: 9, bottom: 8, left: 12),
          child: CircleAvatar(
            radius: 20,
            child: GestureDetector(
              onTap: (){
                
              },
              child: ClipOval(
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/128/3135/3135715.png",
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryItemList extends StatelessWidget {
  const CategoryItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var categories = snapshot.data!.docs;
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              var category = categories[index];
              return CategoryItem(
                image: category['image'],
                text: category['text'],
                onTap: () {
            
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Screen(category: category['text']),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (_, __) {
              return SizedBox(width: 10);
            },
          );
        },
      ),
    );
  }
}
class TopDoctorsList extends StatelessWidget {
  final CollectionReference doctorsCollection = FirebaseFirestore.instance.collection('doctors');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: doctorsCollection.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No doctors available"));
        }

        final List<QueryDocumentSnapshot> doctors = snapshot.data!.docs;

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            var doctor = doctors[index];
            return TopDoctorCard(
              name: doctor['name'],
              specialty: doctor['specialty'],
              hospital: doctor['hospital'],
              rating: doctor['rating'],
              image: doctor['image'],
            );
          },
        );
      },
    );
  }
}



