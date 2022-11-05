import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_app/views/stafHomePAge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/adminController.dart';
import '../helper/authentication helpper.dart';
import '../helper/firebase_database.dart';
import 'AdminHomePAge.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdminController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return (c.a1.isAdmin == true) ? AdminHomePage() : StafHomePage();
  }
}
