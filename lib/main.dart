import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:group_project/AirplaneRegisterpage.dart';
import 'package:group_project/Airplane_list_page.dart';
import 'package:group_project/FlightRegistration.dart';
import 'package:group_project/FlightsListPage.dart';
import 'package:group_project/ReservationList.dart';
import 'package:group_project/ReservationPage.dart';

import 'AppLocalizations.dart';
import 'CustomerListPage.dart';
import 'Customer_Registration.dart';


void main() {
  runApp(const MyApp());
}
                //not stateless as we want to change the language
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  //given setLocale method in module
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLanguage(newLocale);
  }
  //override the method
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }

}


  class _MyAppState extends State<MyApp> {

  //create the variable for Locale
    var locale = Locale("en","CA");

    void changeLanguage(Locale newLang){
      setState(() {
        locale = newLang; //gui to respond
      });
    }

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        //declares the supportedLanguages for the application
        supportedLocales: [
                       Locale("de","DE"),
                        Locale("en","CA"),
                        Locale("fr","CA")
        ],

        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],

        //set the default language
        locale:locale,


        //decides the routes of the pages for the application
        routes: {
          //it will be sorted & defined as key and value pairs

          '/homePage': (context) => MyHomePage(title:AppLocalizations.of(context)!.translate("application_Title")!,),
          '/registerPage': (context) => CustomerRegistration(),
          '/listPage': (context) => CustomerListPage(),
          '/airplaneRegister' : (context) => AirplaneRegister(),
          '/airplaneList' : (context) => AirplaneListPage(),
          '/reservationPage': (context) => ReservationPage(),
          '/reservationList': (context) => ReservationList(),
          '/flightRegister': (context) => FLightRegistration(),
          '/flightListPage': (context) => FlightsListPage()

        },
        initialRoute: '/homePage',
        title: 'Home page',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true,
        ),

      );
    }

  }


///MyHomePage class
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

//create the variable
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

///class that contains four button which redirects different pages
class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        //implement a button to change the language to all the appzlication pages.
        actions: [
          OutlinedButton( onPressed: showTranslateButton, child: Icon(Icons.translate), style: OutlinedButton.styleFrom(side: BorderSide.none, ),)
        ],

      ),
      body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //1. Button for the customer Register Button.
              //change the button Text language when altering language
              ElevatedButton(onPressed: CustomerregistrationDirector, child: Text( AppLocalizations.of(context)!.translate("register_button")!),),
              SizedBox(height: 10,),

              //4.button for Airplane List
              ElevatedButton(onPressed:airplaneRegisterDirector , child: Text(AppLocalizations.of(context)!.translate("airplane_list")!)),
              SizedBox(height: 10,),


              //2.Button for Reservation Page
              ElevatedButton(onPressed:reservationDirector, child: Text(AppLocalizations.of(context)!.translate("reservation_page")!)),
              SizedBox(height: 10,),

              //3. button for Flights Page
              ElevatedButton(onPressed: flightsDirector, child: Text(AppLocalizations.of(context)!.translate("flights_Page")!) ),
              SizedBox(height: 10,),



            ],
          )


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }




 ///function which show the alert dialog to select the language
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

///Function that redirects to register page.
  void CustomerregistrationDirector() {
    Navigator.pushNamed(context, '/registerPage');
  }

  ///function that redirects to register page for airplanes
void airplaneRegisterDirector() {
    Navigator.pushNamed(context, '/airplaneRegister');
}

///Function to redirect to register page for the reservation
void reservationDirector() {
    Navigator.pushNamed(context, '/reservationPage');
}

///function to redirect to flight register page.
void flightsDirector(){
    Navigator.pushNamed(context, '/flightRegister');
}


}
