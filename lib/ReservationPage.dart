import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomerDAO.dart';
import 'ProjectDatabase.dart';
import 'Reservation.dart';
import 'ReservationDAO.dart';

class ReservationPage extends StatefulWidget {
  @override
  State<ReservationPage> createState() => ReservationPageState();

}

class ReservationPageState extends State<ReservationPage> {
  late ReservationDAO reservationDAO;
  late CustomerDAO customerDAO;
  static List<Reservation> reservationList = [];

  String? selectedCustomer;
  String? selectedFlight;
  late List<String> customersList = [];
  late List<String> flightsList = [];
  late TextEditingController _reservationDate;
  late TextEditingController _reservationName;

  //Created the encrypted Shared preferences variable
  late EncryptedSharedPreferences savedReservation;

  @override
  void initState() {
    super.initState();
    _reservationName = TextEditingController();

    //initialize the SavedReservation object
    savedReservation = EncryptedSharedPreferences();



    //creating the database connection
    $FloorProjectDatabase.databaseBuilder("app_database.db").build().then((database) {
      reservationDAO = database.getReservationDAO;
      customerDAO = database.getCustomerDAO;
      reservationDAO.getAllReservations().then((listofReservation) {
        reservationList.addAll(listofReservation);


      });
    });
    //savedReservation() function called
    savedReservationData();
  }


  void _addReservation() async {
          if(_reservationDate ==  null || _reservationName.value.text == null ) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Missing Fields!'),
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
      Navigator.pushNamed(context, "/reservationList"); //redirect to the home page

      //database stuff to add the customer
      var reservation = Reservation(Reservation.ID++, _reservationDate.value.text, _reservationName.value.text);
      //add to the list first
      reservationList.add(reservation);

      //invoking a method to insert the new customer into the table
       reservationDAO.insertReservation(reservation);
    //add the reservationName to the encryptedSharedPreferences file
    sendReservationData();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reservation added')),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Page'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Instructions'),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('1. Adding a Reservation:\n'
                        '- Enter the name of the reservation in the text field provided.\n'
                        '- Press the "Add Reservation" button to add the reservation to the list.'),
                        SizedBox(height: 10),
                        Text('2. Viewing Reservation Details:\n'
                         '- Tap on any reservation in the list to view its details.'),
                        SizedBox(height: 10),
                        Text('3. Copying Previous Customer Information:\n'
                        '- When adding a new customer, you can choose to copy the information from the previous customer.'),
                        SizedBox(height: 10),
                        Text('4. Navigation:\n'
                       '- Use the back button or the app\'s navigation controls to go back to the home page or other sections of the app.'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    )
                  ],
                ),
              );
            },
            icon: Icon(Icons.info),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedCustomer,
              hint: Text('Select Customer'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCustomer = newValue;
                });
              },
              items: customersList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedFlight,
              hint: Text('Select Flight'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFlight = newValue;
                });
              },
              items: flightsList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _reservationName,
              decoration: InputDecoration(
                hintText: "Enter Reservation Name",
                border: OutlineInputBorder(),
                labelText: "Reservation Name",
              ),
              maxLength: 30,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _reservationDate,
              decoration: InputDecoration(
                hintText: "Enter Reservation Date",
                border: OutlineInputBorder(),
                labelText: "Reservation Date",
              ),
              maxLength: 30,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addReservation,
              child: Text('Add Reservation'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Function to save the reservation data

  void sendReservationData(){
    savedReservation.setString("reservation_Name", _reservationName.value.text);
    savedReservation.setString("reservation_Date", _reservationDate.value.text);
  }

//put the previously used customer value to the TextField when loading the page second time.
  void savedReservationData() {
    savedReservation.getString("reservation_Name").then((encryptedReservation) {
      if(encryptedReservation !=null){
        _reservationName.text = encryptedReservation;
      }

      });

    savedReservation.getString("reservation_Date").then((encryptedReservationDate) {
      if(encryptedReservationDate !=null){
        _reservationName.text = encryptedReservationDate;
      }

    });
  }
  void navigateToRL(){
    Navigator.pushNamed(context,'/reservation');
  }
}
