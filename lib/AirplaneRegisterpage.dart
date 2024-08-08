import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/CustomerDatabase.dart';

import 'airplane.dart';
import 'airplane_dao.dart';

///This is the Airplane the register page where the user register all the airplanes

class AirplaneRegister extends StatefulWidget {

  ///Title of the page
  String title = "Airplane Register Page";

  @override
  State<AirplaneRegister> createState() {
    return AirplaneRegistrationState() ;
  }

}

///registration class
class AirplaneRegistrationState extends State<AirplaneRegister> {

  ///create the dao object
  late AirplaneDao airplanedao;

  ///List of the Airplane
  static List<Airplane> airplaneList = [];


  ///TextEditing Controller where the user enters the details of the Airplane
  late TextEditingController _airplaneType;
  late TextEditingController _number_passenger;
  late TextEditingController _maximum_speed;
  late TextEditingController _distance;

  ///create an object of the EncryptedSharedPreferences to save the flight data into the file.
  late EncryptedSharedPreferences savedAirplane;


  @override
  void dispose() {
    _airplaneType.dispose();
    _number_passenger.dispose();
    _maximum_speed.dispose();
    _distance.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //Initialize all the variable fields
    _airplaneType = TextEditingController();
    _number_passenger = TextEditingController();
    _maximum_speed = TextEditingController();
    _distance = TextEditingController();

    ///Pending the FloorDatabase thing
    //add the migration

    final migration1to2 = Migration(1, 2, (database) async {
      await database.execute(
        "CREATE TABLE IF NOT EXISTS `Airplane` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `airplaneType` TEXT, `PassengerNum` TEXT, `maxSpeed` TEXT, `distance` TEXT)",
      );
    });
    //creating the database connection
    $FloorCustomerDatabase.databaseBuilder("app_database.db").addMigrations([migration1to2]).build().then((database) {
      airplanedao = database.getAirplaneDAO; // instantiate the database object
      //fetch the customer from the customerList and put all into the database
      airplanedao.getAllAirPlanes().then((listOfAirplanes) {
        airplaneList.addAll(listOfAirplanes); // when loading the page , all the existing customer should be in the list.

      }); // get all customers
    }); // FloorCustomerDatabase


    //initialize the savedAirplane EncryptedSharedPreferences object
    savedAirplane = EncryptedSharedPreferences();

    //remaining calling the function to saved the data
    savedData();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(widget.title,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold))
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text("Airplane Registration",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),

            //First row of the text field for the airplanetype
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: () {  }, child: Icon(Icons.airplane_ticket)),
                //column for the other field
                Container(
                  width: 300, // Adjust the width as needed
                  padding: const EdgeInsets.all(10.0), // Optional: Add padding
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), // Optional: Add margin
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Add background color
                    borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                  ),
                  child: TextField(controller: _airplaneType,
                      decoration: InputDecoration(
                          hintText:"please enter the Airplane Type",
                          border: OutlineInputBorder(),
                          labelText: "Airplane Type"
                      )),
                ),
              ],
            ),


                ///second row of the textfield.
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
                      child: TextField(controller: _number_passenger,
                          decoration: InputDecoration(
                              hintText:"Please enter the number of passengers",
                              border: OutlineInputBorder(),
                              labelText: "No. of passenger "
                          )),
                    ),
                  ],),

                ///Third TextField of the registration
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: () {  }, child: Icon(Icons.speed)),
                    //column for the other field
                    Container(
                      width: 300, // Adjust the width as needed
                      padding: const EdgeInsets.all(10.0), // Optional: Add padding
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), // Optional: Add margin
                      decoration: BoxDecoration(
                        color: Colors.white, // Optional: Add background color
                        borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                      ),
                      child: TextField(controller: _maximum_speed,
                          decoration: InputDecoration(
                              hintText:"Please enter the Maximum Speed",
                              border: OutlineInputBorder(),
                              labelText: "Max Speed."
                          )),
                    ),
                  ],),

                ///Fourth Last TextField for the registration
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: () {  }, child: Icon(Icons.social_distance_sharp)),
                    //column for the other field
                    Container(
                      width: 300, // Adjust the width as needed
                      padding: const EdgeInsets.all(10.0), // Optional: Add padding
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), // Optional: Add margin
                      decoration: BoxDecoration(
                        color: Colors.white, // Optional: Add background color
                        borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                      ),
                      child: TextField(controller: _distance,
                          decoration: InputDecoration(
                              hintText:"Please Enter the range(distance)",
                              border: OutlineInputBorder(),
                              labelText: "Distance"
                          )),
                    ),
                  ],),

                //creating Register button to register the user as the customer
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: FilledButton(
                    onPressed: addAirplane,
                    child: Text("Add Airplane", style: TextStyle(fontSize: 20)),
                  ),
                ),

          ],
        ),
      ),
    );


  }

  void addAirplane() {
    //condition to check that No TextField have been empty
    if(_airplaneType.value.text == "" || _number_passenger.value.text == "" || _maximum_speed.value.text == "" || _distance.value.text == "")
    {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text("Invalid Infomation"),
          content:  Text("Please fill out all the information"),
          actions: <Widget>[
            ElevatedButton(onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),),
          ],
        ),
      );
    }

    else {
      var snackBar = SnackBar( content: Text("Airplane successfully added", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.green),) );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushNamed(context, "/airplaneList");

      ///adding to the database

      //database stuff to add the customer
      var newAirplane = Airplane(Airplane.ID++, _airplaneType.value.text, _number_passenger.value.text, _maximum_speed.value.text, _distance.value.text,);

      //add to the list first
      airplaneList.add(newAirplane);

      //invoking a method to insert the new customer into the table
      airplanedao.insertAirplane(newAirplane);
      //send the information to the encryptedSharedPreferences file
      sendAirplaneData();
    }

  }


  ///function to send the Airplane data to encryptedSharedPreferences
  void sendAirplaneData(){
    savedAirplane.setString("Airplane_Type", _airplaneType.value.text);
    savedAirplane.setString("NoPassenger", _number_passenger.value.text);
    savedAirplane.setString("max_speed", _maximum_speed.value.text);
    savedAirplane.setString("distance", _distance.value.text);
  }
  ///function to load the data from the EncryptedSharedPreferences file
  void savedData() {
    //get the string from saved File when loading the page
    savedAirplane.getString("Airplane_Type").then((encryptedAirType) {
      if (encryptedAirType  != null ){
        _airplaneType.text = encryptedAirType; // reassign the textField value to saved one.
        displaySnackBarClearData(); //calling a function when firstName contains a value.
      }
    });

    //get the string from saved File when loading the page
    savedAirplane.getString("NoPassenger").then((encryptedPNum) {
      if (encryptedPNum  != null ){
        _number_passenger.text = encryptedPNum; // reassign the textField value to saved one.
      }
    });

    //get the string from saved File when loading the page
    savedAirplane.getString("max_speed").then((encryptedMaxSpeed) {
      if (encryptedMaxSpeed  != null ){
        _maximum_speed.text = encryptedMaxSpeed; // reassign the textField value to saved one.
      }
    });

    //get the string from saved File when loading the page
    savedAirplane.getString("distance").then((encryptedDistance) {
      if (encryptedDistance  != null ){
        _maximum_speed.text = encryptedDistance; // reassign the textField value to saved one.
      }
    });




  }

  ///function to display the snackbar to clear the previous customer information
  void displaySnackBarClearData() {
    var snackBar = SnackBar(content: Text("previous aiplane infomations have been loaded ! "),
        action:SnackBarAction(label:"clear data",onPressed: removingTextFied,));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

  ///clear the TextField
  void removingTextFied() async {
    List<String> keysToRemove = [
      "Airplane_Type",
      "NoPassenger",
      "max_speed",
      "distance",
    ];

    //Handle the unwanted excpetion
    for (var key in keysToRemove) {
      try {
        await savedAirplane.remove(key);
        print('Successfully removed key: $key');
      } catch (e) {
        print('Error removing key $key: $e');
      }
    }

    // Clear TextField values
    _airplaneType.text = "";
    _number_passenger.text = "";
    _maximum_speed.text = "";
    _distance.text="";}

}
