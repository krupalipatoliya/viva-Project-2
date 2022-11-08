import 'package:get/get.dart';

class Admin {
  Admin._();

  static final Admin admin = Admin._();

  RxBool isAdmin = true.obs;
}
