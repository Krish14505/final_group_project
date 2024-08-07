import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:group_project/CustomerAppLocalizations.dart';

import 'CustomerListPage.dart';
import 'Customer_Registration.dart';

void main() {
  runApp(const MyApp());
}
                //not stateless as we want to change the language
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  //override the method
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }

  //given setLocale method in module
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLanguage(newLocale); // calls changeLanguage
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
                        Locale("en","CA"),
                        Locale("de","DE")

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
          '/homePage': (context) => MyHomePage(title: 'Airline Management',),
          '/registerPage': (context) => CustomerRegistration(),
          '/listPage': (context) => CustomerListPage(),
          //add other pages that you have made.


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



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: registrationDirector, child: Text("Registration Page"),),
            ],
          )

      ),

    );
  }

  void registrationDirector() {
    Navigator.pushNamed(context, '/registerPage');
  }
}
