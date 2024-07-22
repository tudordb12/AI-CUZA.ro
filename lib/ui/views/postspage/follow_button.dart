import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final bool isFollowed;
  void Function()? onTap;

  FollowButton({super.key, required this.isFollowed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isFollowed ? 145 : 125,
        height: 50,
        decoration: BoxDecoration(
          color: isFollowed
              ? Color.fromARGB(255, 117, 75, 241)
              : Color.fromARGB(255, 69, 0, 217),
          borderRadius: BorderRadius.circular(360),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Align(
              child: Row(
                children: [
                  Icon(
                    size: 20.0,
                    isFollowed
                        ? Icons.library_add_check_rounded
                        : Icons.add_alert,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    isFollowed ? "F O L L O W I N G" : "F O L L O W",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
