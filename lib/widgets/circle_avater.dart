import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCircleAvater extends StatelessWidget {
  final Function() onTap;
  final Image image;

  const AppCircleAvater({Key? key, required this.onTap, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(1, 1))
            ]),
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.white,
          child: image,
        ),
      ),
    );
  }
}
