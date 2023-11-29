import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Class/user.dart';
import 'Style/assets/fonts/weights.dart';
import 'Style/colors_style.dart';

class ProfileDisplay extends StatefulWidget {
  final User user;
  const ProfileDisplay({super.key, required this.user});

  @override
  State<ProfileDisplay> createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.user.pfp),
          radius: 120,
        ),
        const SizedBox(
          width: 35,
        ),
        Stack(
          children: [
            Text(
              'Welcome !',
              style: GoogleFonts.mukta(
                color: Theme.of(context).colorScheme.outline,
                fontSize: 60,
                fontWeight: bold,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 55,),
                Text(
                  widget.user.name,
                  style: GoogleFonts.mukta(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 70,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 150,),
                Text(
                  '@${widget.user.username}',
                  style: GoogleFonts.oxanium(
                    color: colorGray,
                    fontSize: 20,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
