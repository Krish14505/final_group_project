import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/AirplaneRegisterpage.dart';


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


        //decides the routes of the pages for the application
        routes: {
          //it will be sorted & defined as key and value pairs
          '/homePage': (context) => MyHomePage(title: "Aiplane Registration ",),
          '/airplaneRegister' : (context) => AirplaneRegister(),
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


///MyHomePage class
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


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

      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(onPressed: () {Navigator.pushNamed(context, "/airplaneRegister"); } , child: Text("Go to Airplane List page"),)],
          )

      ),

    );
  }

}
