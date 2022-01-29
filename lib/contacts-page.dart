import 'package:flutter/material.dart';

import 'dummydata.dart';
import 'models/contact.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Future<List<Contact>>? _contacts;

  Future<List<Contact>> _getContacts() async {
    List<Contact> contacts = dummyData;
    await Future.delayed(Duration(seconds: 10));
    return Future.value(contacts);
  }

  @override
  void initState() {
    super.initState();
    _contacts = _getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
