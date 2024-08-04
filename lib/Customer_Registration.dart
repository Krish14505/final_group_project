import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/Customer.dart';
import 'package:group_project/CustomerDAO.dart';
import 'package:group_project/CustomerDataRepository.dart';
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

      });

    });

    //saved preferences for the previously created customer
    CustomerDataRepository.first_name = _firstName.value.text;
    CustomerDataRepository.last_name = _lastName.value.text;
    CustomerDataRepository.email  = _email.value.text;
    CustomerDataRepository.phoneNumber = _phoneNumber.value.text;
    CustomerDataRepository.address = _address.value.text;
    CustomerDataRepository.birthday = _birthday.value.text;

    //loading the data
    CustomerDataRepository.loadData();

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

    CustomerDataRepository.saveData();

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

        //empty all the spaces.

      _firstName.text = " ";
      _lastName.text =" ";
      _email.text =  " ";
      _phoneNumber.text =  " ";
      _address.text = " ";
      _birthday.text =  " ";
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



}