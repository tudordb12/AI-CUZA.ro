import 'package:flutter/material.dart';

class postDeleteBtn extends StatelessWidget {
  void Function()? onTap;
  postDeleteBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(360)),
            color: Color.fromARGB(58, 255, 255, 255),
            child: Icon(
                  size: 35,
                  Icons.clear,
                  color: Color.fromARGB(206, 255, 255, 255),
                ),
          )),
    );
  }
}
