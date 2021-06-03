import 'package:flutter/material.dart';

import 'application_form/applicantformUi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This is the root widget of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Information Request Form',

      home: Scaffold(
        appBar: AppBar(
          title: Text('Medical Information Request Form',style: new TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: ApplicantForm(),
      ),

      //ApplicantForm(),
    );
  }
}
