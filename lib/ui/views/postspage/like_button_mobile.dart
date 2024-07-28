import 'package:flutter/material.dart';

class LikeButtonMobile extends StatelessWidget {
  final bool isLiked;
  void Function()? onTap;
  LikeButtonMobile({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
       height: 50,
        decoration: BoxDecoration(
         //  color: Colors.white,
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
          ],
        ),
      ), // Icon
    ); // GestureDetector
  }
}
