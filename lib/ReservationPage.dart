import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppLocalizations.dart';
import 'CustomerDAO.dart';
import 'FlightsDAO.dart';
import 'ProjectDatabase.dart';
import 'Reservation.dart';
import 'ReservationDAO.dart';
import 'main.dart';

class ReservationPage extends StatefulWidget {
  @override
  State<ReservationPage> createState() => ReservationPageState();

}

class ReservationPageState extends State<ReservationPage> {
  late ReservationDAO reservationDAO;
  late CustomerDAO customerDAO;
  late FlightsDAO flightsDAO;
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
    _reservationDate = TextEditingController();
    savedReservation = EncryptedSharedPreferences();

    $FloorProjectDatabase.databaseBuilder('app_database.db')
        .build()
        .then((database) {
      reservationDAO = database.getReservationDAO;
      customerDAO = database.getCustomerDAO;
      flightsDAO = database.getFlightDAO;
      print('Database initialized: $reservationDAO, $customerDAO, $flightsDAO');
      reservationDAO.getAllReservations().then((listOfReservations) {
        setState(() {
          reservationList = listOfReservations;
        });
      }).catchError((error) {
        print('Error loading reservations: $error');
      });
      savedReservationData();
      loadCustomersAndFlights();
    });
  }


  void loadCustomersAndFlights() {
    // Adding customer first name.
    customerDAO.getAllCustomers().then((customers) {
      setState(() {
        customersList = customers.map((customer) => customer.first_name).toList();
      });
    }).catchError((error) {
      print('Error loading customers: $error');
    });

    // For testing, hardcoded flight data
    flightsList = ['Flight1', 'Flight2', 'Flight3', 'Flight4', 'Flight5'];
    setState(() {}); // Ensure the UI is updated after setting flightsList
  }


  @override
  void dispose() {
    _reservationName.dispose();
    _reservationDate.dispose();
  }

  void _addReservation() async {
          if(_reservationDate.text.isEmpty || _reservationName.text.isEmpty ) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title:  Text(AppLocalizations.of(context)!.translate("RPalertDioalogT")! ),
            content: Text(AppLocalizations.of(context)!.translate("RPalertDioalogC")!),
            actions: <Widget>[
              ElevatedButton(onPressed: () => Navigator.pop(context, AppLocalizations.of(context)!.translate("about_regi_description")!),
                child:  Text( AppLocalizations.of(context)!.translate("ok")!),
              )],
          ),
        );
      }
    //each of fields is filled then the following:
    else {
      var snackBar = SnackBar( content: Text(AppLocalizations.of(context)!.translate("RPsuccussMsg")!, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.green),) );
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate("RPtitle")!),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.translate("RPinstructionT")!),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(AppLocalizations.of(context)!.translate("RPaddResIns")!),
                        SizedBox(height: 10),
                        Text(AppLocalizations.of(context)!.translate("RPviewResIns")!),
                        SizedBox(height: 10),
                        Text(AppLocalizations.of(context)!.translate("RPcopyIns")!),
                        SizedBox(height: 10),
                        Text(AppLocalizations.of(context)!.translate("RPnavIns")!),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.translate("ok")!),
                    )
                  ],
                ),
              );
            },
            icon: Icon(Icons.info),
          ),

          ///Added the Language Translator Icon for changing language
          OutlinedButton( onPressed: showTranslateButton, child: Icon(Icons.language_outlined), style: OutlinedButton.styleFrom(side: BorderSide.none, ),),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedCustomer,
              hint: Text(AppLocalizations.of(context)!.translate("RPddmCN")!),
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
              hint: Text(AppLocalizations.of(context)!.translate("RPddmFN")!),
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
                hintText: AppLocalizations.of(context)!.translate("RPresnameH"),
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.translate("RPresnameL"),
              ),
              maxLength: 30,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _reservationDate,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.translate("RPresdateH"),
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.translate("RPresdateL"),
              ),
              maxLength: 30,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addReservation,
              child: Text(AppLocalizations.of(context)!.translate("RPaddButton")!),
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
        _reservationDate.text = encryptedReservationDate;
      }

    });
  }
  void navigateToRL(){
    Navigator.pushNamed(context,'/reservation');
  }


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