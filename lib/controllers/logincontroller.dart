import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;

  updateEmail(string){
    email.value = string;
  }
  updateFirstName(string){
    firstName.value = string;
  }

  updateLastName(string){
    lastName.value = string;
  }
}