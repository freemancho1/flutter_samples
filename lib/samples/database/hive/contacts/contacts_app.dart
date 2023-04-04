import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/contacts/contact_add.dart';
import 'package:flutter_samples/samples/database/hive/contacts/contact_list.dart';

class ContactsApp extends StatelessWidget {
  const ContactsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Contacts'),),
    body: ContactList(),
    floatingActionButton: FloatingActionButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ContactAdd()),
      ),
      child: const Icon(Icons.add),
    ),
  );
}
