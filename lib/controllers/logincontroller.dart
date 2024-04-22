import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var firstName = ''.obs;
  updateEmail(string){
    email.value = string;
  }
  updateFirstName(string){
    firstName.value = string;
  }
}