import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFDF7FD),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate responsive sizes based on available width
          final isSmallScreen = constraints.maxWidth < 800;
          final mainFontSize = isSmallScreen ? 24.0 : 36.0;
          final subFontSize = isSmallScreen ? 14.0 : 18.0;
          final letterSpacing = isSmallScreen ? 8.0 : 16.0;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // HIMALAYAN
              _buildAcronymPart(
                mainLetter: 'H',
                subText: 'IMALAYAN',
                mainFontSize: mainFontSize,
                subFontSize: subFontSize,
              ),
              SizedBox(width: letterSpacing),

              // EELITE
              _buildAcronymPart(
                mainLetter: 'E',
                subText: 'ELITE',
                mainFontSize: mainFontSize,
                subFontSize: subFontSize,
              ),
              SizedBox(width: letterSpacing),

              // ADVENTURE
              _buildAcronymPart(
                mainLetter: 'A',
                subText: 'DVENTURE',
                mainFontSize: mainFontSize,
                subFontSize: subFontSize,
              ),
              SizedBox(width: letterSpacing),

              // TOURISM
              _buildAcronymPart(
                mainLetter: 'T',
                subText: 'OURISM',
                mainFontSize: mainFontSize,
                subFontSize: subFontSize,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAcronymPart({
    required String mainLetter,
    required String subText,
    required double mainFontSize,
    required double subFontSize,
  }) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.notoSerif(
          fontWeight: FontWeight.bold,
          fontSize: mainFontSize,
          color: Colors.black,
        ),
        children: [
          TextSpan(text: mainLetter),
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(2, 0),
              child: Text(
                subText,
                style: GoogleFonts.notoSerif(
                  fontWeight: FontWeight.w400,
                  fontSize: subFontSize,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}