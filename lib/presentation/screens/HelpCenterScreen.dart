import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/PickColorHelper.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
      appBar: AppBar(
        backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
        title: Text('Help Center',
            style: TextStyle(color: ColorPickerHelper.colorHelper('mainTextColor'))),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: ColorPickerHelper.colorHelper('mainTextColor'),),
          onPressed:() {
            Navigator.pop(context);
            },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/HelpCenterImage.png'),
            SizedBox(height: 50),
            Text('Help Center',
            style: TextStyle(
                color: ColorPickerHelper.colorHelper('mainTextColor'),
            fontSize: 22.0),),
            SizedBox(height: 15.0),
            Text('For any support kind of request regards your\n booking or services please feel free to speak\n with us at below.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorPickerHelper.colorHelper('secondaryTextColor'),
                  fontSize: 16.0),),
            SizedBox(height: 80),
            Text('Call us - +962 780680780\nMail us - SwiftClean@mail.com',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorPickerHelper.colorHelper('mainTextColor'),
                  fontSize: 16.0),),


          ],
        ),
      ),
    );
  }
}
