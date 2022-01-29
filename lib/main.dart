import 'package:flutter/material.dart';
import 'contacts-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        backgroundColor: const Color(0xFFFAFAFA),
        body: const ContactsPage(),
      ),
    );
  }
}
