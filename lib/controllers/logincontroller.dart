import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  updateEmail(string){
    email.value = string;
  }
}