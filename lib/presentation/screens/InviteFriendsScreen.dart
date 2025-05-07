import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing_firebase/core/constants/PickColorHelper.dart';
import 'package:testing_firebase/presentation/widgets/BuildReferralCodeWidget.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({Key? key}) : super(key: key);

  @override
  _InviteFriendsScreenState createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  late String referralCode;
  final Color mainTextColor = const Color(0xFF333E63);
  final Color secondaryTextColor = const Color(0xFFA1BBD0);

  @override
  void initState() {
    super.initState();
    // Generate a random referral code for this user
    referralCode = generateReferralCode();
  }

  String generateReferralCode() {
    // Generate a random alphanumeric string of length 6
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Referral code copied to clipboard!',
          style: TextStyle(fontFamily: 'Gilroy'),
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Invite Friends',
          style: TextStyle(
            color: mainTextColor,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Illustration image
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/inviteFriends.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Text content
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Description text
                  Text(
                    'Invite friends to get Free Delivery for next booking if your friend sign up with your referral code.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: mainTextColor,
                      fontFamily: 'Gilroy',
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // "Share your code" text
                  Text(
                    'Share your code',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontFamily: 'Gilroy',
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Referral code container with copy button
                  _buildReferralCode(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralCode() {
    // Using our reusable widget
    return buildReferralCodeWidget(
      referralCode,
      context,
      mainTextColor: mainTextColor,
      buttonColor: Colors.blue,
    );
  }
}