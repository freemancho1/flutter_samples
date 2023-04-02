import 'package:flutter/material.dart';

class MenuCfg {
  static const TextStyle groupTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    // color: Colors.deepOrange,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle groupSubTitleStyle = TextStyle(
    // color: Colors.orange,
    color: Colors.blueGrey,
    overflow: TextOverflow.ellipsis,
  );
  static const Color textColor = Colors.blueGrey;
  static const Color activeTextColor = Colors.deepOrange;
  static const Color groupBgColor = Colors.white;
  static const bool groupInitExpanded = false;

  static const TextStyle itemTitleStyle = TextStyle(
    fontSize: 17,
    color: Colors.deepOrange,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle itemSubTitleStyle1 = TextStyle(
    fontSize: 15,
    color: Colors.deepOrange[200],
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle itemSubTitleStyle2 = TextStyle(
    fontSize: 15,
    color: Colors.blueGrey,
    overflow: TextOverflow.ellipsis,
  );
  static const double itemWidth = double.infinity;
  // static const double itemHeight = 70.0;
  static const EdgeInsetsGeometry itemPadding = EdgeInsets.only(
      left: 57, right: 10, bottom: 10
  );
}