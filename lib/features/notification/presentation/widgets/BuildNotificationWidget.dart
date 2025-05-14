import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget buildNotificationWidget(IconData icon, String title,String desc, Color fieldBackgroundColor, Color mainTextColor, Color secondaryTextColor) {
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
    padding: EdgeInsets.all(7.0),
    margin: EdgeInsets.fromLTRB(3, 0, 3, 8),
    child: ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16,color: mainTextColor),
          ),
          Text(
            desc,
            style: TextStyle(fontSize: 14,color: secondaryTextColor),
          )
        ],
      ),
      onTap: () {
        // Handle menu item tap
      },
    ),
  );
}