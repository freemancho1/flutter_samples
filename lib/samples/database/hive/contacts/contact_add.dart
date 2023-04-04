import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/samples/database/hive/contacts/contact.dart';
import 'package:flutter_samples/samples/database/hive/hive_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ContactAdd extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  ContactAdd({super.key});

  @override
  State<ContactAdd> createState() => _ContactAddState();
}

class _ContactAddState extends State<ContactAdd> {
  final Box<Contact> contactBox = Hive.box<Contact>(HiveCfg.tableContactName);
  late String name;
  late int age;
  late String phoneNumber;
  late Relationship relationship;

  void onFormSubmit() {
    if (widget.formKey.currentState!.validate()) {
      /// 여기서는 왜 await를 사용하지 않나?
      contactBox.add(Contact(name, age, phoneNumber, relationship));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('신규 연락처 등록'),),
    body: SafeArea(
      child: Form(
        key: widget.formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            TextFormField(
              autofocus: true,
              initialValue: '',
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter a Name'
              ),
              onChanged: (value) => setState(() => name = value),
            ),
            const SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: '',
              maxLength: 3,
              /// 사용자가 maxLength 보다 더 입력하려고 하면 강제로 막음
              /// (위 3글자 이상이면 더 이상 입력되지 않음)
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: const InputDecoration(
                labelText: 'Age'
              ),
              onChanged: (value) => setState(() => age = int.parse(value)),
            ),
            const SizedBox(height: 5,),
            TextFormField(
              keyboardType: TextInputType.phone,
              initialValue: '',
              decoration: const InputDecoration(
                labelText: 'Phone'
              ),
              onChanged: (value) => setState(() => phoneNumber = value),
            ),
            const SizedBox(height: 5,),
            /// enum class를 이용한 DropdownButton 만들기
            DropdownButtonFormField(
              items: relationships.keys.map((value) =>
                DropdownMenuItem(
                  value: value,
                  child: Text(relationships[value]!)
                )
              ).toList(),
              /// value값을 주면 사용자가 선택하지 않을 수 있고,
              /// 사용자가 선택하지 않으면 onChanged가 실행되지 않기 때문에
              /// 저장할 때 오류가 발생함 (가급적 value를 사용하지 말고, hint를 이용할 것)
              /// value: Relationship.family,
              hint: const Text('Relationship'),
              onChanged: (value) => setState(() => relationship = value!)
            ),
            const SizedBox(height: 5,),
            OutlinedButton(
              onPressed: onFormSubmit,
              child: const Text('등록')
            ),
            const SizedBox(height: 5,),
          ],
        ),
      ),
    ),
  );
}