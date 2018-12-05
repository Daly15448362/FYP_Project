import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fyp_project/headings/label.dart';
import 'package:fyp_project/database/databasestorage.dart';
import 'package:fyp_project/widgets/main_page.dart';

void main() async {
  DatabaseService databaseService = new DatabaseService();
  await databaseService.open();
  runApp(new MyApp(databaseService: databaseService));
}

class MyApp extends StatelessWidget {
  final DatabaseService databaseService;

  const MyApp({Key key, this.databaseService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daly Budget',

      
      theme: new ThemeData(

          brightness: Brightness.light,
          primarySwatch: Colors.green,
          accentColor: Colors.yellow),

      home: new MainPage(databaseService: databaseService,),
    );
  }
}
