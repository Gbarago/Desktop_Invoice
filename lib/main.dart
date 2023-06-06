import 'package:flutter/material.dart';

import 'Views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const textTheme = TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Spartan',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        // color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Spartan',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        //color: Colors.black,
      ),

      bodyLarge: TextStyle(
        fontFamily: 'Spartan',
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Spartan',
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      // Add more text styles as needed
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: textTheme,
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
