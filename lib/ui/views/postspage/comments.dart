import 'package:flutter/material.dart';

class Comment extends StatelessWidget{
  final String text;
  final String user;
  final String time;
  const Comment({
    required this.text,
    required this.user,
    required this.time,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(61, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
               Icon(
          size: 30,
           Icons.comment_outlined,
           color: Colors.white,),
           SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(text, style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w900, color: Color.fromARGB(255, 255, 255, 255)),),
                  SizedBox(height: 10,),
                  Text(user, style: TextStyle(fontWeight: FontWeight.w100, color: Color.fromARGB(148, 255, 255, 255)),),
                    Text(time, style: TextStyle(fontWeight: FontWeight.w100, color: Color.fromARGB(148, 255, 255, 255)),),
                  
                ]),
            ],
          ),
        ),
        
        ),
    );
  }


}