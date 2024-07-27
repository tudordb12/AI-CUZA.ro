import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'postspage_viewmodel.dart';

class mobileMenu extends StatelessWidget {
  const mobileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 59, 56, 75),
      width: double.infinity,
      height: 80,
      child: Center(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(
            flex: 2,
          ),
          Container(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    color: Colors.white70,
                    size: 30.0,
                  ))),
          Container(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.batch_prediction_rounded,
                    color: Colors.white70,
                    size: 30.0,
                  ))),
          Container(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.question_mark,
                    color: Colors.white70,
                    size: 30.0,
                  ))),
          Container(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.alternate_email_sharp,
                    color: Colors.white70,
                    size: 30.0,
                  ))),
          Container(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_pin_rounded,
                    color: Colors.white70,
                    size: 30.0,
                  ))),
          Container(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.white70,
                    size: 30.0,
                  ))),
          Spacer(
            flex: 2,
          ),
        ],
      )),
    );
  }
}
