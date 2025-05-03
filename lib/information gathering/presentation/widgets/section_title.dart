import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double bottomPadding;

  const SectionTitle({
    Key? key,
    required this.title,
    this.bottomPadding = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}