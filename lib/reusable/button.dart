import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final Color back;
  final String text;
  final Color textColor;
  const Clickable({Key? key, required this.back, required this.text,required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.35,
      height: 40,
      decoration: BoxDecoration(
        color: back,
        borderRadius: BorderRadius.circular(3),
        boxShadow: const<BoxShadow>[
          BoxShadow(
            color: Color.fromARGB(199, 97, 97, 97),
            offset: Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 1
          )
        ]
      ),
      child: Text(text,style: TextStyle(color: textColor,fontWeight: FontWeight.w600,fontSize: 14),),
    );
  }
}
