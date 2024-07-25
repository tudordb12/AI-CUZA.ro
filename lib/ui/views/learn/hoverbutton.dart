import 'package:flutter/material.dart';

class HoverableButton extends StatelessWidget {
  final bool isHovered;
  final VoidCallback onEnter;
  final VoidCallback onExit;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  HoverableButton({
    required this.isHovered,
    required this.onEnter,
    required this.onExit,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          MouseRegion(
            onEnter: (_) => onEnter(),
            onExit: (_) => onExit(),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color: isHovered ? Colors.yellow : Color.fromARGB(86, 255, 255, 255),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: Colors.yellow.withOpacity(0.6),
                          spreadRadius: 8,
                          blurRadius: 15,
                          offset: Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                  ),
                  child: Icon(
                    icon,
                    size: 150,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            label,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
          ),
        ],
      ),
    );
  }
}
