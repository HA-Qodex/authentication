import 'package:fltr_database/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData iconData;
  final TextInputType inputType;
  final bool obscureText;

  const AppTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.hint,
      required this.iconData,
      required this.inputType,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          TextFormField(
            obscureText: obscureText,
            controller: controller,
            cursorColor: AppColors.grey,
            keyboardType: inputType,
            style: GoogleFonts.lato(color: Colors.black, fontSize: 17),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Icon(iconData, color: AppColors.primary),
              hintText: hint,
              hintStyle: GoogleFonts.lato(color: AppColors.grey, fontSize: 15),
              labelText: label,
              labelStyle: GoogleFonts.lato(
                  color: AppColors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColors.grey, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColors.primary, width: 2)),
            ),
          ),
        ],
      ),
    );
  }
}
