import 'package:flutter/material.dart';
import 'package:videogame_review_app/App_Constant/app_constant.dart';

class GenresWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  const GenresWidget({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      height: 30,
      // width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 142, 84, 151)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: wColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Icon(
            icon,
            color: Colors.amber,
            size: 15,
          )
        ],
      ),
    );
  }
}
