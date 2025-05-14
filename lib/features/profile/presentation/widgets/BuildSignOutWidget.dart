import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSignOutItem(IconData icon, String title) {
  return Container(
    decoration: BoxDecoration(
        color: Color(0x4DFE7058),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.25),
            blurRadius: 5,
          )
        ]
    ),
    height: 60.0,
    margin: EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 5.0),
    child: ListTile(
      leading: Icon(icon, color: Color(0xFFFE7058)),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Color(0xFFFE7058)),
      ),
      onTap: () {
        // Handle menu item tap
      },
    ),
  );
}