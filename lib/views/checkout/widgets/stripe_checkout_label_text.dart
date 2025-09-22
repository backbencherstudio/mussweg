import 'package:flutter/material.dart';

class StripeCheckoutLabelText extends StatelessWidget {
  final String labelText;
  final bool isRequired;
  final TextStyle labelStyle;

  const StripeCheckoutLabelText ({
    required this.labelText,
    this.isRequired = true,
    this.labelStyle = const TextStyle(
      color: Color(0xFF777980),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: labelStyle,
        children: <TextSpan>[
          TextSpan(text: labelText),
        ],
      ),
    );
  }
}
