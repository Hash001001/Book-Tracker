import 'package:flutter/material.dart';
import 'package:flutter_book_reader/providers/home_provider.dart';
import 'package:flutter_book_reader/screens/book_details.dart';
import 'package:flutter_book_reader/screens/favorites_screen.dart';
import 'package:flutter_book_reader/screens/home_screen.dart';
import 'package:flutter_book_reader/screens/main/main_home.dart';
import 'package:flutter_book_reader/screens/save_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
      ),
      initialRoute: '/',
      routes: {
        "/home": (context) => HomeScreen(),
        "/saved": (context) => SavedScreen(),
        "/favorites": (context) => FavoritesScreen(),
        "/details": (context) => BookDetailsScreen(),
      },
      home: const MainHome(),
    );
  }
}
