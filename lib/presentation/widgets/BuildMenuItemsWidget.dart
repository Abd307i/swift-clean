import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget buildMenuItem(IconData icon, String title, Color fieldBackgroundColor, Color mainTextColor) {
  return Container(
    decoration: BoxDecoration(
        color: fieldBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.25),
            blurRadius: 5,
          )
        ]
    ),
    height: 60.0,
    margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
    child: ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: TextStyle(fontSize: 16,color: mainTextColor),
      ),
      onTap: () {
        // Handle menu item tap
      },
    ),
  );
}