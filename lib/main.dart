import 'package:employees_app/views/home_page.dart';
import 'package:employees_app/views/log_in_page.dart';
import 'package:employees_app/views/roles_identifier_screen.dart';
import 'package:employees_app/views/sign_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      themeMode: ThemeMode.light,
      initialRoute: 'RoleFinder',
      getPages: [
        GetPage(name: '/', page: () => const LogINPage()),
        GetPage(name: '/SignInPage', page: () => const SignInPage()),
        GetPage(name: '/RoleFinder', page: () => const RoleFinder()),
        GetPage(name: '/HomePage', page: () => const HomePage()),
      ],
    ),
  );
}
