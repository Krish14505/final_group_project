import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/CustomerListPage.dart';
import 'Airplane_list_page.dart';



import 'Customer_Registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      //decides the routes of the pages for the application
      routes: {
        //it will be sorted & defined as key and value pairs
        '/homePage' : (context) => MyHomePage(title: 'Airline Management',),
        '/airplaneListPage': (context) => AirplaneListPage(),
        // Add this line
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
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/registerPage'),
              child: Text("Registration Page"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/airplaneListPage'),
              child: Text("Airplane List Page"),
            ),

            // New Button for adding airplanes
          ],
        ),
      ),
    );
  }
}
