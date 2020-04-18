import 'package:flutter/material.dart';
import './providers/entries.dart';
import './screens/category_page.dart';
import './screens/home_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider.value(
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
