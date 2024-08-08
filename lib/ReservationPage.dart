import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppLocalizations.dart';
import 'CustomerDAO.dart';
import 'CustomerDatabase.dart';
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

    //add the migration to keep the reservation table in the same customerDatabase
    final migration2to3 = Migration(2, 3, (database) async{
      await database.execute(
        "CREATE TABLE IF NOT EXISTS 'Reservation' (`reservationId` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `reservationDate` TEXT, `reservationName` TEXT)"
      );
    });

    //creating the database connection
    $FloorCustomerDatabase.databaseBuilder("app_database.db").addMigrations([migration2to3]).build().then((database) {
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
        _reservationName.text = encryptedReservationDate;
      }

    });
  }
  void navigateToRL(){
    Navigator.pushNamed(context,'/reservation');
  }
}

void showTranslateButton(){
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