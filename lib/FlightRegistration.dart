
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Flight.dart';
import 'FlightsDAO.dart';
import 'ProjectDatabase.dart';

class FLightRegistration extends StatefulWidget{

  String title = "Flight List Page";
  @override
  State<StatefulWidget> createState() {

    return FlightListPageState();
  }


}

class FlightListPageState extends State<FLightRegistration>{

  late FlightsDAO flightsDAO;
  static List<Flight> flightList = [ ];



  late int selected;
  late TextEditingController _destinationController ;
  late TextEditingController _sourceController ;
  late TextEditingController _departureController ;
  late TextEditingController _arrivalController ;

  //use the encrypted shared preferences
  late EncryptedSharedPreferences savedFlight;

  @override
  void dispose() {
    _destinationController = TextEditingController();
    _sourceController = TextEditingController();
    _departureController = TextEditingController();
    _arrivalController = TextEditingController();
    super.dispose();

  }

  @override
  void initState() {
    super.initState();
    _destinationController = TextEditingController();
    _sourceController = TextEditingController();
    _departureController = TextEditingController();
    _arrivalController  =TextEditingController();



    $FloorProjectDatabase.databaseBuilder("app_database.db").build().then((database) {
        flightsDAO = database.getFlightDAO;

        flightsDAO.getAllFlights().then((listofFlights) {
          flightList.addAll(listofFlights);
        });
    });

    savedFlight = EncryptedSharedPreferences();

    savedData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Flight Registration",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),

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
                  child: TextField(controller: _destinationController,
                      decoration: InputDecoration(
                          hintText:"Please enter the destination",
                          border: OutlineInputBorder(),
                          labelText: "destination"
                      )),
                ),
              ],
            ),

            //second TextField
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
                  child: TextField(controller: _sourceController,
                      decoration: InputDecoration(
                          hintText:"please enter source",
                          border: OutlineInputBorder(),
                          labelText: "Source"
                      )),
                ),
              ],
            ),

            //third Textfield
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
                  child: TextField(controller: _departureController,
                      decoration: InputDecoration(
                          hintText:"please enter the departure",
                          border: OutlineInputBorder(),
                          labelText: "departure"
                      )),
                ),
              ],
            ),


            //fourth Textfield
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
                  child: TextField(controller: _arrivalController,
                      decoration: InputDecoration(
                          hintText:"please enter the arrival",
                          border: OutlineInputBorder(),
                          labelText: "arrival"
                      )),
                ),
              ],
            ),

            //creating Register button to register the user as the customer
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: FilledButton(
                onPressed: addFlight,
                child: Text("Add Flight", style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //function for add Flight
void addFlight() {
  //condition to check that No TextField have been empty
  if(_destinationController.value.text == "" || _departureController.value.text == "" || _sourceController.value.text == "" || _arrivalController.value.text == "")
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
    var snackBar = SnackBar( content: Text("Fight successfully added", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.green),) );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.pushNamed(context, "/flightList");

    ///adding to the database

    //database stuff to add the customer
    var newFlight = Flight(Flight.ID++, _destinationController.value.text, _sourceController.value.text, _arrivalController.value.text, _departureController.value.text,);

    //add to the list first
    flightList.add(newFlight);

    //invoking a method to insert the new customer into the table
    flightsDAO.addFlight(newFlight);
    //send the information to the encryptedSharedPreferences file
    sendAirplaneData();
  }
}

//function that creates the Flight data to encryptedSharedPreferences
void sendAirplaneData() {
    savedFlight.setString("departure", _departureController.value.text);
    savedFlight.setString("arrival", _arrivalController.value.text);
    savedFlight.setString("destination", _destinationController.value.text);
    savedFlight.setString("source", _sourceController.value.text);
}

//function that load the data from the EncryptedSharedPreferences

void savedData(){

    //departure
    savedFlight.getString("departure").then((encryptedDeparture) {
      if(encryptedDeparture != null) {
        _departureController.text = encryptedDeparture;
        displaySnackBarClearData();
      }
    });

    // arrival
    savedFlight.getString("arrival").then((encryptedArrival) {
      if(encryptedArrival != null) {
        _departureController.text =encryptedArrival;
      }
    });

    //destination
  savedFlight.getString("destination").then((encryptedDestination) {
      if(encryptedDestination != null){
        _destinationController.text = encryptedDestination;
      }
    });

    //source
  savedFlight.getString("source").then((encryptedSource) {
      if(encryptedSource != null) {
        _sourceController.text = encryptedSource;
      }
  });
}

void displaySnackBarClearData(){
  var snackBar = SnackBar(content: Text("previous Fligh Information have been loaded! "),
      action:SnackBarAction(label:"clear data",onPressed: removingTextFied,));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

}

  void removingTextFied() async {
    List<String> keysToRemove = [
      "departure",
      "arrival",
      "destination",
      "source",
    ];

    //Handle the unwanted excpetion
    for (var key in keysToRemove) {
      try {
        await savedFlight.remove(key);
        print('Successfully removed key: $key');
      } catch (e) {
        print('Error removing key $key: $e');
      }
    }

    // Clear TextField values
    _sourceController.text = "";
    _arrivalController.text = "";
    _destinationController.text= "";
    _departureController.text = "";
  }

}


