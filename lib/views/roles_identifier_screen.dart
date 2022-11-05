import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/adminController.dart';

class RoleFinder extends StatefulWidget {
  const RoleFinder({Key? key}) : super(key: key);

  @override
  State<RoleFinder> createState() => _RoleFinderState();
}

class _RoleFinderState extends State<RoleFinder> {
  final AdminController c = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Role"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                c.ontap();
                Get.offNamedUntil('/', (route) => false);
              },
              child: Text("Log In As Admin"),
            ),
            TextButton(
              onPressed: () {
                Get.offNamedUntil('/', (route) => false);
              },
              child: Text("Log In As Staf"),
            ),
          ],
        ),
      ),
    );
  }
}
