import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/authentication helpper.dart';
import '../helper/firebase_database.dart';

class StafHomePage extends StatefulWidget {
  const StafHomePage({Key? key}) : super(key: key);

  @override
  State<StafHomePage> createState() => _StafHomePageState();
}

class _StafHomePageState extends State<StafHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FireBaseCloudHelpper.fireBaseCloudHelpper.fetchAllData();
  }

  final Stream<QuerySnapshot<Object?>> _usersStream =
      FireBaseCloudHelpper.fireBaseCloudHelpper.fetchAllData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: const Text("Staff Page"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              FireBaseAuthHelpper.fireBaseAuthHelpper.signOut();
              Get.offAllNamed('RoleFinder');
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Get.changeTheme((Get.isDarkMode == true)
                  ? ThemeData.dark()
                  : ThemeData.light());
            },
            icon: Icon(Icons.light_mode_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot<Object?>> data =
                        snapshot.data!.docs;

                    print(data);

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView(
                        children: data.map((e) {
                          Map<String, dynamic> data =
                              e.data() as Map<String, dynamic>;

                          return Card(
                            elevation: 2,
                            color: Colors.blue.shade100,
                            child: ListTile(
                              subtitle: Text("Role : ${data['role']}"),
                              title: Text("Name : ${data['name']}"),
                              isThreeLine: true,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error}',
                      ),
                    );
                  }
                  return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
