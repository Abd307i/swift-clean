import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../core/constants/PickColorHelper.dart';

Widget notificationSettings(String switchText, bool isClicked){
  return Container(
    color: ColorPickerHelper.colorHelper('backgroundColor'),
    padding: EdgeInsets.all(20),
    height: 80.0,
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(switchText,
            style: TextStyle(
              fontSize: 18.0,
                color: ColorPickerHelper.colorHelper('mainTextColor')
            )
        ),
        Switch(
            value:isClicked,
            onChanged: (bool newSwitchValue) {}
        )
      ],
    ),
  );
}
