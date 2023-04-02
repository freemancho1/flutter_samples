import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoCfg {
  static TextStyle titleStyle(bool done) => TextStyle(
    color: Colors.redAccent,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    decoration: done ? TextDecoration.lineThrough : null,
    overflow: TextOverflow.ellipsis
  );
  static TextStyle dateTimeStyle = TextStyle(
    fontSize: 16, color: Colors.orange[600],
  );
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
}