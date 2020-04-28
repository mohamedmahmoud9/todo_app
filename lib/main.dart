import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './providers/entries.dart';
import './screens/category_page.dart';
import './screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Entries(),
      child: MaterialApp(
        title: 'ToDo App',
        theme: ThemeData(
          primaryColor: Colors.white,
          // primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        
        routes: {
          CategoryPage.routeName: (ctx) => CategoryPage(),
        },
      ),
    );
  }
}
