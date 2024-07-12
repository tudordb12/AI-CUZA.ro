import 'package:flutter/material.dart';

class commentDeleteBtn extends StatelessWidget {
  void Function()? onTap;
   commentDeleteBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Icon(
          size: 35,
          Icons.delete,
          color: Color.fromARGB(206, 255, 255, 255),
        )),
    );
  }
}