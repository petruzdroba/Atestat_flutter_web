import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/assets/fonts/weights.dart';
import 'package:google_fonts/google_fonts.dart';

class MediumCenterBox extends StatefulWidget {
  final Widget child;
  final String title;

  const MediumCenterBox(
      {super.key,
      required this.child,
      required this.title,});

  @override
  State<MediumCenterBox> createState() => _MediumCenterBoxState();
}

class _MediumCenterBoxState extends State<MediumCenterBox> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(45.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).colorScheme.outline,
                  child: Center(
                    child: Text(
                      widget.title,
                      style: GoogleFonts.mukta(
                          fontSize: 30,
                          fontWeight: semiBold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                )),
            Expanded(flex: 7, child: widget.child),
          ],
        ),
      ),
    );
  }
}
