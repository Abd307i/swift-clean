import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildReferralCodeWidget(
    String code,
    BuildContext context, {
      Color mainTextColor = const Color(0xFF333E63),
      Color buttonColor = Colors.blue,
    }) {
  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Referral code copied to clipboard!',
          style: TextStyle(fontFamily: 'Gilroy'),
        ),
        backgroundColor: buttonColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  return Container(
    height: 56,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        // Code display area
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              code,
              style: TextStyle(
                color: mainTextColor,
                fontFamily: 'Gilroy',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),

        // Copy button
        GestureDetector(
          onTap: copyToClipboard,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.content_copy,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    ),
  );
}