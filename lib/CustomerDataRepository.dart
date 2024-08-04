
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

///This normal class is used to store the user data as encrypted

class CustomerDataRepository {

  //static --> can be accessed outside of the class..
  static  String first_name = " ";
  static String last_name = " ";
  static  String phoneNumber= " ";
  static String email= " ";
  static String address = " ";
  static  String birthday= " ";


  //load the data what saved inasdfjkasl each field
static void loadData() {
//creating the variable that holds EncryptedSharedPreferences()
  var prefs = EncryptedSharedPreferences();

  prefs.getString("first_name").then((encryptedFName) {
    first_name = encryptedFName;
  });

  prefs.getString("last_name").then((encryptedLName) {
      last_name = encryptedLName;
  });

  prefs.getString("phoneNumber").then((encryptedPhoneNum) {
      phoneNumber = encryptedPhoneNum;
  });

  prefs.getString("email").then((encryptedEmail) {
    email = encryptedEmail;
  });

  prefs.getString("address").then((encryptedAddress)  {
    address = encryptedAddress;
  });

  prefs.getString("birthday").then((encryptedBirthDay) {
    birthday = encryptedBirthDay;
  });

}

static void saveData() {
  var prefs = EncryptedSharedPreferences();

  prefs.setString("first_name", first_name);
  prefs.setString("last_name", last_name);
  prefs.setString("phoneNumber", phoneNumber);
  prefs.setString("email",email);
  prefs.setString("address", address);
  prefs.setString("birthday", birthday);

}


}