import 'package:flutter/material.dart';

class profilePicBtn extends StatelessWidget {
  void Function()? onTap;
  profilePicBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: Color.fromARGB(184, 255, 8, 49),
            borderRadius: BorderRadius.circular(360)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            size: 30,
            Icons.add_a_photo_outlined,
            color: Color.fromARGB(206, 255, 255, 255),
          ),
        ),
      )),
    );
  }
}
