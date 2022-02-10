import 'package:catalog/screens/newtask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/tasklist.dart';
import 'models/selectedtab.dart';

import 'screens/homepage.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskList>(
          create: (context) => TaskList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Images',
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/new': (context) => NewTaskPage(),
        },
      ),
    );
  }
}
