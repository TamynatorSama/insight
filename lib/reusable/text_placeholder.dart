import 'package:flutter/material.dart';

class TextPlace extends StatefulWidget {
  final String text;
  final Color color;
  const TextPlace({Key? key, required this.color,required this.text}) : super(key: key);

  @override
  State<TextPlace> createState() => _TextPlaceState();
}

class _TextPlaceState extends State<TextPlace>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    controller!.forward();
    controller!.repeat();
    controller!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: controller!.value,
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: widget.color, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}
