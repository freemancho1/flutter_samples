import 'package:fluent_ui/fluent_ui.dart';

void main() {
  String a = '123456';
  List<String> aList = Characters(a).toList();
  debugPrint('a: $a, aList: $aList');
  aList.length--;
  debugPrint('aList: $aList');
  debugPrint('aList: ${aList.join()}');
  debugPrint('a: ${a.substring(0, a.length-1)}');

  String? b = '';
  if (b.isEmpty) {
    debugPrint('Empty');
  } else {
    debugPrint('Not Empty');
  }
  debugPrint('b--: ${b.substring(0, b.length-1)}');
}