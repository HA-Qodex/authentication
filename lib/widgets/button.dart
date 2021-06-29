import 'package:fltr_database/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final Function() onPressed;
  final String title;

  const AppButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minimumSize: Size(width, 45),
      ),
    );
  }
}
