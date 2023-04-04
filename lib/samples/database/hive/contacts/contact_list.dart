import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/contacts/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_config.dart';

class ContactList extends StatelessWidget {
  ContactList({Key? key}) : super(key: key);
  final Box<Contact> contactBox = Hive.box<Contact>(HiveCfg.tableContactName);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: contactBox.listenable(),
    builder: (context, box, _) => (box.values.isEmpty)
      ? const Center(child: Text('No Contacts'),)
      : ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            Contact contact = box.getAt(index)!;

            /* String relationship = contact.relationship!;
               이렇게 해도 되지 않나? */
            String relationship = relationships[contact.relationship]!;
          },
        ),
  );
}
