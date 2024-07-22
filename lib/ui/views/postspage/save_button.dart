import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final bool isSaved;
  void Function()? onTap;
  SaveButton({super.key, required this.isSaved, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(360),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  size: 25,
                  isSaved ? Icons.bookmark : Icons.bookmark_add_outlined,
                  color: isSaved
                      ? Color.fromARGB(255, 255, 157, 0)
                      : Color.fromARGB(255, 255, 157, 0),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                isSaved ? 'S A V E D' : 'S A V E',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
      ), // Icon
    ); // GestureDetector
  }
}
