import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  void Function()? onTap;
  LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
         // color: Colors.white,
          borderRadius: BorderRadius.circular(360),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               Center(
                 child: Icon(
                  size: 25,
                         isLiked ? Icons.favorite : Icons.favorite_border,
                         color: isLiked ? Color.fromARGB(255, 255, 0, 68) : Colors.grey,
                       ),
               ),
        SizedBox(width: 10,),
        Text(isLiked ? 'L I K E D' : 'L I K E', style: TextStyle(color: Colors.black),) 
        ],),
      ), // Icon
    ); // GestureDetector
  }
}





