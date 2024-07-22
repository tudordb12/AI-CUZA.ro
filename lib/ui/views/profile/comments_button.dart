import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  //final bool isLiked;
  void Function()? onPressed;
  CommentButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 5, 166, 194),
            borderRadius: BorderRadius.circular(360),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Center(
                child: Icon(
                  size: 25,
                  Icons.comment,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'C O M E N T E A Z Ă',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ), // Icon
    ); // GestureDetector
  }
}
