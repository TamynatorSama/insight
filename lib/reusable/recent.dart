import 'package:flutter/material.dart';

class Recent extends StatelessWidget {
  final String text;
  final VoidCallback hello;
  const Recent({Key? key, required this.text, required this.hello}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onDoubleTap: hello,
          child: const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Hero(
              tag: "cool",
              child: Icon(
                Icons.cancel_outlined,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Text(text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ))
      ],
    );
  }
}
