import 'package:employees_app/models/andmin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleFinder extends StatefulWidget {
  const RoleFinder({Key? key}) : super(key: key);

  @override
  State<RoleFinder> createState() => _RoleFinderState();
}

class _RoleFinderState extends State<RoleFinder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text("Select Role"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtiUUBlBHALRE7FT7Utu331HN4A47hHQt5zQ&usqp=CAU',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade400 // Text Color
                  ),
              onPressed: () {
                if (Admin.admin.isAdmin == false) {
                  Admin.admin.isAdmin.value = true;
                }

                Get.offNamedUntil('/', (route) => false);
              },
              child: const Text("Log In As Admin",
                  style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade400 // Text Color
                  ),
              onPressed: () {
                if (Admin.admin.isAdmin == true) {
                  Admin.admin.isAdmin.value = false;
                }
                Get.offNamedUntil('/', (route) => false);
              },
              child: const Text("Log In As Staf",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
