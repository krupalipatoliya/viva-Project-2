import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/authentication helpper.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailLogInController = TextEditingController();
  TextEditingController passLogInController = TextEditingController();
  String email = "";
  String password = "";
  final logInKey = GlobalKey<FormState>();
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: Form(
        key: logInKey,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: emailLogInController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Email First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val!;
                  },
                  cursorColor: Colors.blueAccent,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)),
                      labelText: "Email",
                      labelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Colors.grey))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: passLogInController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Password First...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    password = val!;
                  },
                  cursorColor: Colors.blueAccent,
                  obscureText: isSecure,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSecure = !isSecure;
                          });
                        },
                        child: const Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)),
                      labelText: "Password",
                      labelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Colors.grey))),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (logInKey.currentState!.validate()) {
                    logInKey.currentState!.save();
                    await FireBaseAuthHelpper.fireBaseAuthHelpper
                        .SignIn(emailAddress: email, password: password);

                    Get.offAllNamed('HomePage');
                  }
                },
                child: const Text("Sing UP"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  Get.offAllNamed('SignInPage');
                },
                child: const Text("Sing In",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
