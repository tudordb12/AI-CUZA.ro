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
            height: 40,
            width: 40,
            decoration: BoxDecoration(
               color: Color.fromARGB(58, 255, 255, 255),
              borderRadius: BorderRadius.circular(360)),
           
            child: Icon(
                  size: 30,
                  Icons.add,
                  color: Color.fromARGB(206, 255, 255, 255),
                ),
          )),
    );
  }
}