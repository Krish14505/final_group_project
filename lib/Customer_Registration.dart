
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/Customer.dart';
import 'package:group_project/CustomerDAO.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AppLocalizations.dart';
import 'CustomerDatabase.dart';
import 'main.dart';

//Customer Registration page

///class contains the form for registering customer
class CustomerRegistration extends StatefulWidget {
  ///Title of the page
   String  title= "Customer Registration Page" ;

  @override
  State<CustomerRegistration> createState() {
    return CustomerRegistrationState();
  }

}

///registrationState class
class CustomerRegistrationState extends State<CustomerRegistration> {

///Customer dao object
late CustomerDAO customerdao ;

///List of Customer
static List<Customer> customerLists= [];

///Text Editing Controller where user enters required information.
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _email;
  late TextEditingController _phoneNumber;
  late TextEditingController _address;
  late TextEditingController _birthday;

  ///an EncryptedSharedPreference Instance to save Customer information in device file explorer;
  late EncryptedSharedPreferences savedCustomer ;

  @override
  void initState() {
    super.initState(); // initialize all the late variables .
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _phoneNumber = TextEditingController();
    _address = TextEditingController();
    _birthday = TextEditingController();


    //creating the database connection
    $FloorCustomerDatabase.databaseBuilder("app_database.db").build().then((database) {
      customerdao = database.getCustomerDAO; // instantiate the database object

      //fetch the customer from the customerList and put all into the database
      customerdao.getAllCustomers().then((ListOfCustomers) {
        customerLists.addAll(ListOfCustomers); // when loading the page , all the existing customer should be in the list.

      }); // get all customers
    }); // FloorCustomerDatabase


    // initialize the SavedCustomer
    savedCustomer = EncryptedSharedPreferences();

    //call the function SavedData() to place the all the previous customer details to TextField
    savedData();

  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _phoneNumber.dispose();
    _address.dispose();
    _birthday.dispose();
    super.dispose();


  }

  ///button that shows an alert dialog of how to use the page
void HelpButton() {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title:  Text( AppLocalizations.of(context)!.translate("about_regi_key")!), // added the internationalization
      content:  Text(AppLocalizations.of(context)!.translate("about_regi_description")!),
      actions: <Widget>[
       ElevatedButton(onPressed: (){ Navigator.pop(context); }, child: const  Text("Ok"))
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
    appBar: AppBar(backgroundColor: Colors.cyan,
                   title: Text(widget.title,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)) ,
                   actions: [
                     //implement a button to change the language from the registration page.
                       OutlinedButton( onPressed: showTranslateButton, child: Icon(Icons.language_outlined), style: OutlinedButton.styleFrom(side: BorderSide.none, ),),

                     FilledButton(onPressed: HelpButton, child: Icon(Icons.question_mark_sharp)),
                   ],
                  ),
    body: SingleChildScrollView (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.translate("welcome_title_registration")!,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),


          ///first row for the customer last name and first name.
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: () {  }, child: Icon(Icons.person)),
              //column for the other field
              Container(
                width: 300, // Adjust the width as needed
                padding: const EdgeInsets.all(10.0), // Optional: Add padding
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _firstName,
                    decoration: InputDecoration(
                        hintText:AppLocalizations.of(context)!.translate("first_name_text"),
                        border: OutlineInputBorder(),
                        labelText: "First Name"
                    )),
              ),

            ],
          ),

          Row (
            mainAxisAlignment:  MainAxisAlignment.start,
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: () { }, child: Icon(Icons.person)),
              //column for the other field
              Container(
                width: 300, // Adjust the width as needed
                padding: const EdgeInsets.all(10.0), // Optional: Add padding
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),// Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _lastName,
                    decoration: InputDecoration(
                        hintText:AppLocalizations.of(context)!.translate("last_name_text"),
                        border: OutlineInputBorder(),
                        labelText: "Last Name"
                    )),
              ),

            ],
          ),


          Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: () {  }, child: Icon(Icons.email_outlined)),
                //column for the other field
                Container(
                  width: 300, // Adjust the width as needed
                  padding: const EdgeInsets.all(10.0), // Optional: Add padding
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), // Optional: Add margin
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Add background color
                    borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                  ),
                  child: TextField(controller: _birthday,
                      decoration: InputDecoration(
                          hintText:AppLocalizations.of(context)!.translate("birthday_text"),
                          border: OutlineInputBorder(),
                          labelText: "BirthDate"
                      )),
                ),
              ] ),
          //Row for the Phone Number
          Row (
            mainAxisAlignment:  MainAxisAlignment.start,
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: emailLauncher , child: Icon(Icons.email_outlined)),
              Container(
                width: 300, // Adjust the width as needed
                padding: const EdgeInsets.all(10.0), // Optional: Add padding
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _email,
                    decoration: InputDecoration(
                        hintText:AppLocalizations.of(context)!.translate("email_text"),
                        border: OutlineInputBorder(),
                        labelText: "Email"
                    )),
              ),

            ],),

          //Row for the Phone Number
          Row (
            mainAxisAlignment:  MainAxisAlignment.start,
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: PhoneLauncher, child: Icon(Icons.phone)),
              Container(
                width: 300, // Adjust the width as needed
                padding: const EdgeInsets.all(10.0), // Optional: Add padding
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _phoneNumber,
                    decoration: InputDecoration(
                        hintText:AppLocalizations.of(context)!.translate("phone_text"),
                        border: OutlineInputBorder(),
                        labelText: "PhoneNumber"
                    )),
              ),

            ],),
//Row for the Phone Number
          Row (
            mainAxisAlignment:  MainAxisAlignment.start,
            children: [
              ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: ()  { }, child: Icon(Icons.home)),
              Container(
                width: 300, // Adjust the width as needed
                padding: const EdgeInsets.all(10.0), // Optional: Add padding
                margin: const EdgeInsets.fromLTRB(10, 10, 10,10), // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _address,
                    decoration: InputDecoration(
                        hintText:AppLocalizations.of(context)!.translate("address_key"),
                        border: OutlineInputBorder(),
                        labelText: "Address:"
                    )),
              ),
            ],),
          //creating Register button to register the user as the customer
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: FilledButton(
              onPressed: registerCustomer,
              child: Text(AppLocalizations.of(context)!.translate("register_btn")!, style: TextStyle(fontSize: 20)),
            ),
          ),



        ],
      ),

    ),


  );

  }

  ///function when the user clicks on the register button
  void registerCustomer() {

    if(_firstName.value.text ==  ""  || _lastName.value.text == "" || _email.value.text == "" || _phoneNumber.value.text == "" || _birthday.value
        .text == "" || _address.value.text == "" ) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text(AppLocalizations.of(context)!.translate("alert_dialog_title_invalid_data")!),
          content:  Text(AppLocalizations.of(context)!.translate("warning_message_alert_dialog")!),
          actions: <Widget>[
            ElevatedButton(onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),),
          ],
        ),
      );
    }
    //each of fields is filled then the following:
    else {
      var snackBar = SnackBar( content: Text(AppLocalizations.of(context)!.translate("register_Success")!, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.green),) );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ///navigate to the list page
       Navigator.pushNamed(context, "/listPage"); //redirect to the home page


        //database stuff to add the customer
        var newCustomer = Customer(Customer.ID++, _firstName.value.text, _lastName.value.text, _email.value.text, _phoneNumber.value.text, _address.value.text, _birthday.value.text);

        //add to the list first
         customerLists.add(newCustomer);

        //invoking a method to insert the new customer into the table
        customerdao.addCustomer(newCustomer);

       //when the user clicks on the register button it calls this function to save the TextField value to deviceExplorer file
      // in key --> value pairs as Encrypted.
      sendCustomerData();
    }
  }

  ///Function for email url launcher
void  emailLauncher() {
  var userTypedEmailAddress = _email.value.text;
  launch("mailto: "+userTypedEmailAddress);
}


///function for phone Url launcher
void PhoneLauncher() {
    var userTypedPhoneNumber = _phoneNumber.value.text;
    launch("tel: "+userTypedPhoneNumber);
}


///set the values to the encryptedSharedPreferences to what user has typed
  void sendCustomerData(){

    //saved the TextField value to EncryptedSharedPreferences file
    savedCustomer.setString("first_Name", _firstName.value.text);
    savedCustomer.setString("last_Name",  _lastName.value.text);
    savedCustomer.setString("email",  _email.value.text);
    savedCustomer.setString("phoneNumber",_phoneNumber.value.text);
    savedCustomer.setString("address", _address.value.text);
    savedCustomer.setString("birthday", _birthday.value.text);

  }

///Implementing the function to load the saved(previous) customer data
void savedData() {

  //get the string from saved File when loading the page
  savedCustomer.getString("first_Name").then((encryptedFName) {
    if (encryptedFName  != null ){
      _firstName.text = encryptedFName; // reassign the textField value to saved one.
      displaySnackBarClearData(); //calling a function when firstName contains a value.
    }
  });
  //get the string from saved File when loading the page
  savedCustomer.getString("last_Name").then((encryptedLName) {
    if (encryptedLName  != null ){
      _lastName.text = encryptedLName; // reassign the textField value to saved one.
    }

  });

  //get the string from saved File when loading the page
  savedCustomer.getString("email").then((encryptedEmail) {
    if (encryptedEmail  != null ){
      _email.text = encryptedEmail; // reassign the textField value to saved one.
    }
  });
  //get the string from saved File when loading the page
  savedCustomer.getString("phoneNumber").then((encryptedPhone) {
    if (encryptedPhone  != null ){
      _phoneNumber.text = encryptedPhone; // reassign the textField value to saved one.
    }
  });
  //get the string from saved File when loading the page
  savedCustomer.getString("address").then((encryptedAddress) {
    if (encryptedAddress  != null ){
      _address.text = encryptedAddress; // reassign the textField value to saved one.
    }
  });
  //get the string from saved File when loading the page
  savedCustomer.getString("birthday").then((encryptedBday) {
    if (encryptedBday  != null ){
      _birthday.text = encryptedBday; // reassign the textField value to saved one.
    }
  });
}


///function to display the snackbar to clear the previous customer information
  void displaySnackBarClearData() {
    var snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.translate("loaded_data_key")!),
      action:SnackBarAction(label:AppLocalizations.of(context)!.translate("clear_data")!,onPressed: removingTextFied,));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

  ///clear the TextField
  void removingTextFied() async {
    List<String> keysToRemove = [
      "first_Name",
      "last_Name",
      "email",
      "phoneNumber",
      "address",
      "birthday"
    ];

    //Handle the unwanted excpetion
    for (var key in keysToRemove) {
      try {
        await savedCustomer.remove(key);
        print('Successfully removed key: $key');
      } catch (e) {
        print('Error removing key $key: $e');
      }
    }

    // Clear TextField values
    _firstName.text = "";
    _lastName.text = "";
    _email.text = "";
    _phoneNumber.text = "";
    _address.text = "";
    _birthday.text = "";
  }


  ///Function to show an alert-dialog to change the language of the application
//function which show the alert dialog to select the language
  void showTranslateButton() {
    //alert dialog which has three button of the languages
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Choose Language:'),
        content: const Text(''),
        actions: <Widget>[
          //button for french
          FilledButton(onPressed:() {
              MyApp.setLocale(context, Locale("de","DE")); Navigator.pop(context); }, style: OutlinedButton.styleFrom(side: BorderSide.none, ),child: Text(AppLocalizations.of(context)!.translate("german_key")!)),
          ElevatedButton(onPressed:(){
            MyApp.setLocale(context, Locale("en","CA")); Navigator.pop(context);   }, style: OutlinedButton.styleFrom(side: BorderSide.none, ), child: Text(AppLocalizations.of(context)!.translate("english_key")!)),
          ElevatedButton(onPressed:(){
            MyApp.setLocale(context, Locale("fr","CA")); Navigator.pop(context);   }, style: OutlinedButton.styleFrom(side: BorderSide.none, ), child: Text(AppLocalizations.of(context)!.translate("french_key")!)),
        ],
      ),
    );
  }


}