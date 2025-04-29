import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
                fontSize: 27,
              ),
              children: [
                TextSpan(text: 'H',),
                WidgetSpan(
                  child: Transform.translate(
                    offset: Offset(2, 0),
                    child: Text('IMALYAN', textScaler: TextScaler.linear(0.7)),
                  ),
                ),
                WidgetSpan(child: SizedBox(width: 32)),
                TextSpan(text: 'E',),
                WidgetSpan(
                  child: Transform.translate(
                    offset: Offset(2, 0),
                    child: Text('ELITE', textScaler: TextScaler.linear(0.7)),
                  ),
                ),
                WidgetSpan(child: SizedBox(width: 32)),
                TextSpan(text: 'A',),
                WidgetSpan(
                  child: Transform.translate(
                    offset: Offset(2, 0),
                    child: Text('DVENTURE', textScaler: TextScaler.linear(0.7)),
                  ),
                ),
                WidgetSpan(child: SizedBox(width: 32)),xxxxxx
                TextSpan(text: 'T',),
                WidgetSpan(
                  child: Transform.translate(
                    offset: Offset(2, 0),
                    child: Text('OURISM', textScaler: TextScaler.linear(0.7)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
