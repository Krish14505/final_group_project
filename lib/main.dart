import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'AppLocalization.dart';
import 'ReservationList.dart';
import 'ReservationPage.dart';


void main() {
  runApp(const MyApp());
}
//not stateless as we want to change the language
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  //given setLocale method in module
  static void setLocale(BuildContext context, Locale newLocale) async {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state?.changeLanguage(newLocale); // calls changeLanguage
  }

  //override the method
  @override
  State<MyApp> createState() {
    return MyAppState();
  }
}


class MyAppState extends State<MyApp> {

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
        Locale("en","CA"),
        Locale("de","DE"),
        Locale("fr","CA")

      ],

      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],

      //set the default language
      locale:locale,


      //decides the routes of the pages for the application
      routes: {
        //it will be sorted & defined as key and value pairs


        '/reservationpage': (context) => ReservationPage(),
        "/reservation": (context) => ReservationList(),

        //add other pages that you have made.


      },
      initialRoute: '/reservationpage',
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        //implement a button to change the language to all the application pages.



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
              ElevatedButton(onPressed: reservationDirector, child: Text( AppLocalizations.of(context)!.translate("register_button")!),),
              SizedBox(height: 10,),



            ],
          )

      ),

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
  void reservationDirector() {
    Navigator.pushNamed(context, '/reservationpage');
    }

}
