import 'package:get/get.dart';
import '../models/andmin.dart';

class AdminController extends GetxController {
  Admin a1 = Admin(isAdmin: false.obs);

  ontap() {
    a1.isAdmin.value = !a1.isAdmin.value;
  }
}
