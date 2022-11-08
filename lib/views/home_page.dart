
import 'package:employees_app/views/stafHomePAge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/andmin.dart';
import 'AdminHomePAge.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        (Admin.admin.isAdmin.value) ? const AdminHomePage() : const StafHomePage());
  }
}
