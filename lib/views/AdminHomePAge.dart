import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_app/helper/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/authentication helpper.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController updateAgeController = TextEditingController();
  TextEditingController updateRoleController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateSalaryController = TextEditingController();

  GlobalKey<FormState> addEmployee = GlobalKey<FormState>();
  GlobalKey<FormState> updateEmployee = GlobalKey<FormState>();

  String role = "";
  String name = "";
  int age = 0;
  int salary = 0;
  int r = 0;
  int s = 0;

  String b = "";
  String a = "";

  // int i = 4;

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
        title: const Text("All Employees Name"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              FireBaseAuthHelpper.fireBaseAuthHelpper.signOut();
              Get.offAllNamed('RoleFinder');
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Get.changeTheme((Get.isDarkMode == true)
                  ? ThemeData.dark()
                  : ThemeData.light());
            },
            icon: const Icon(Icons.light_mode_rounded),
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

                          print(e);

                          return Card(
                            child: ListTile(
                              subtitle: Text("Role : ${data['role']}"),
                              title: Text("Name : ${data['name']}"),
                              isThreeLine: true,
                              trailing: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      FireBaseCloudHelpper.fireBaseCloudHelpper
                                          .deleteUser(i: e.id);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          updateSalaryController.text =
                                              data['salary'].toString();
                                          updateRoleController.text =
                                              data['role'];
                                          updateNameController.text =
                                              data['name'];
                                          updateAgeController.text =
                                              data['age'].toString();
                                          return AlertDialog(
                                            title: const Text("Fill This"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  b = "";
                                                  a = "";
                                                  s = 0;
                                                  r = 0;
                                                  updateNameController.clear();
                                                  updateRoleController.clear();
                                                  updateSalaryController
                                                      .clear();
                                                  updateAgeController.clear();

                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  if (updateEmployee
                                                      .currentState!
                                                      .validate()) {
                                                    updateEmployee.currentState!
                                                        .save();

                                                    FireBaseCloudHelpper
                                                        .fireBaseCloudHelpper
                                                        .updateUser(
                                                            age: r,
                                                            name: a,
                                                            role: b,
                                                            salary: s,
                                                            i: e.id);

                                                    b = "";
                                                    a = "";
                                                    s = 0;
                                                    r = 0;

                                                    updateNameController
                                                        .clear();
                                                    updateRoleController
                                                        .clear();
                                                    updateSalaryController
                                                        .clear();
                                                    updateAgeController.clear();

                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: const Text("Update"),
                                              ),
                                            ],
                                            content: Form(
                                              key: updateEmployee,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        updateNameController,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Please Enter Name First...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      a = val!;
                                                    },
                                                    cursorColor:
                                                        Colors.blueAccent,
                                                    decoration: InputDecoration(
                                                      border:
                                                          const OutlineInputBorder(),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent),
                                                      ),
                                                      labelText: "Name",
                                                      labelStyle:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        updateRoleController,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Please Enter Role First...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      b = val!;
                                                    },
                                                    cursorColor:
                                                        Colors.blueAccent,
                                                    decoration: InputDecoration(
                                                        border:
                                                            const OutlineInputBorder(),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .blueAccent)),
                                                        labelText: "Role",
                                                        labelStyle: GoogleFonts.poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey))),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    controller: ageController,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Please Enter Age First...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      r = int.parse(val!);
                                                    },
                                                    cursorColor:
                                                        Colors.blueAccent,
                                                    decoration: InputDecoration(
                                                        border:
                                                            const OutlineInputBorder(),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .blueAccent)),
                                                        labelText: "Age",
                                                        labelStyle: GoogleFonts.poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey))),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        salaryController,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Please Enter Salary First...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      s = int.parse(val!);
                                                    },
                                                    cursorColor:
                                                        Colors.blueAccent,
                                                    decoration: InputDecoration(
                                                        border:
                                                            const OutlineInputBorder(),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .blueAccent)),
                                                        labelText: "Salary",
                                                        labelStyle: GoogleFonts.poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Fill This"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        name = "";
                        role = "";
                        age = 0;
                        salary = 00;

                        nameController.clear();
                        salaryController.clear();
                        ageController.clear();
                        roleController.clear();

                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (addEmployee.currentState!.validate()) {
                          addEmployee.currentState!.save();

                          FireBaseCloudHelpper.fireBaseCloudHelpper.addUser(
                              name: name, age: age, role: role, salary: salary);

                          name = "";
                          role = "";
                          age = 0;
                          salary = 00;

                          nameController.clear();
                          salaryController.clear();
                          ageController.clear();
                          roleController.clear();

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ],
                  content: Form(
                    key: addEmployee,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Name First...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            name = val!;
                          },
                          cursorColor: Colors.blueAccent,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              labelText: "Name",
                              labelStyle: GoogleFonts.poppins(
                                  textStyle:
                                      const TextStyle(color: Colors.grey))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: roleController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Role First...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            role = val!;
                          },
                          cursorColor: Colors.blueAccent,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              labelText: "Role",
                              labelStyle: GoogleFonts.poppins(
                                  textStyle:
                                      const TextStyle(color: Colors.grey))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: ageController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Age First...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            age = int.parse(val!);
                          },
                          cursorColor: Colors.blueAccent,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              labelText: "Age",
                              labelStyle: GoogleFonts.poppins(
                                  textStyle:
                                      const TextStyle(color: Colors.grey))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: salaryController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Salary First...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            salary = int.parse(val!);
                          },
                          cursorColor: Colors.blueAccent,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              labelText: "Salary",
                              labelStyle: GoogleFonts.poppins(
                                  textStyle:
                                      const TextStyle(color: Colors.grey))),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
