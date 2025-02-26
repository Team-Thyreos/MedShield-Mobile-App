import 'package:flutter/material.dart';
import 'package:medshield/constants.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    required this.colour,
    this.icon,
    this.label,
    this.value,
    this.child,
    Key? key,
  }) : super(key: key);

  final Color colour;
  final IconData? icon;
  final String? label;
  final String? value;
  final Widget? child; // Allows adding custom widgets like buttons

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (icon != null) Icon(icon, size: 40.0),
            if (label != null) const SizedBox(height: 1.0),
            if (label != null)
              Text(
                label!,
                style: kLabelTextStyle,
              ),
            if (value != null) const SizedBox(height: 1.0),
            if (value != null)
              Text(
                value!,
                style: kNumberTextStyle,
              ),
            if (child != null) child!, // Custom content for interactive cards
          ],
        ),
      ),
    );
  }
}
