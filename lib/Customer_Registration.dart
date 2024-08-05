import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/Customer.dart';
import 'package:group_project/CustomerDAO.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CustomerDatabase.dart';

class CustomerRegistration extends StatefulWidget {
   String  title= "Customer Registration Page" ;

  @override
  State<CustomerRegistration> createState() {
    return CustomerRegistrationState();
  }

}

class CustomerRegistrationState extends State<CustomerRegistration> {

//variables should be defined here.
//creating the dao object
late CustomerDAO customerdao ;
static List<Customer> customerLists= [];

  ///declare all the variables used in the textfield.
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _email;
  late TextEditingController _phoneNumber;
  late TextEditingController _address;
  late TextEditingController _birthday;

  //creating a EncryptedSharedPreference Instance;
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


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
    appBar: AppBar(backgroundColor: Colors.cyan,title: Text(widget.title,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)) ,),
    body: SingleChildScrollView (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 20),
          Text("Welcome to the Registration Page",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),


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
                        hintText:"Enter  First Name",
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
                        hintText:"Enter Last Name",
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
                          hintText:"Enter Date Of Birth",
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
                        hintText:"Enter Your Email address",
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
                        hintText:"Enter phone number ",
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
                        hintText:"Enter Your Address",
                        border: OutlineInputBorder(),
                        labelText: "Address:"
                    )),
              ),
            ],),
          //creating Register button to register the user as the customer
          SizedBox(
            width: 300, // Set the width of the button
            height: 60, // Set the height of the button
            child:
            Expanded (
              flex: 10,
              child: FilledButton(
                onPressed: registerCustomer,
                child: Text("Register", style: TextStyle(fontSize: 20)), // Adjust font size if needed
              ),
            )
            ,
          ),


        ],
      ),

    ),


  );

  }

  void registerCustomer() {

    if(_firstName.value.text ==  ""  || _lastName.value.text == "" || _email.value.text == "" || _phoneNumber.value.text == "" || _birthday.value
        .text == "" || _address.value.text == "" ) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Incomplete Registration! '),
          content: const Text('Please Fill out all the fields.'),
          actions: <Widget>[
            ElevatedButton(onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),),
          ],
        ),
      );
    }
    //each of fields is filled then the following:
    else {
      var snackBar = SnackBar( content: Text('successfully Registered!', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.green),) );
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

void  emailLauncher() {
  var userTypedEmailAddress = _email.value.text;
  launch("mailto: "+userTypedEmailAddress);
}


void PhoneLauncher() {
    var userTypedPhoneNumber = _phoneNumber.value.text;
    launch("tel: "+userTypedPhoneNumber);
}


//set the values to the encryptedSharedPreferences to what user has typed
  void sendCustomerData(){

    //saved the TextField value to EncryptedSharedPreferences file
    savedCustomer.setString("first_Name", _firstName.value.text);
    savedCustomer.setString("last_Name",  _lastName.value.text);
    savedCustomer.setString("email",  _email.value.text);
    savedCustomer.setString("phoneNumber",  _phoneNumber.value.text);
    savedCustomer.setString("address", _phoneNumber.value.text);
    savedCustomer.setString("birthday", _birthday.value.text);

  }

//Implementing the function to load the saved(previous) customer data
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


  void displaySnackBarClearData() {
    var snackBar = SnackBar(content: Text("The Previous customer informations have been loaded ! "),
      action:SnackBarAction(label:"Clear Saved Data",onPressed: removingTextFied,));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

  //clear the TextField
  void removingTextFied() {
    //remove first from the encryptedSharedPreferences
    savedCustomer.remove("first_Name");
    savedCustomer.remove("last_Name");
    savedCustomer.remove("email");
    savedCustomer.remove("phoneNumber");
    savedCustomer.remove("address");
    savedCustomer.remove("birthday");

    //remove the TextField values
    _firstName.text = "";
    _lastName.text = "";
    _email.text = "";
    _phoneNumber.text = "";
    _address.text= "";
    _birthday.text = "";
  }

}