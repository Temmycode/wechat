import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? align;
  final TextOverflow? overflow;

  const AppText(this.text, {super.key, this.style, this.align, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      style: GoogleFonts.plusJakartaSans(textStyle: style),
    );
  }
}
