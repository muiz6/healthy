import 'package:flutter/material.dart';

class FlipCameraButton extends StatefulWidget {
  final void Function()? onPressed;

  FlipCameraButton({this.onPressed});

  @override
  State<FlipCameraButton> createState() => _FlipCameraButtonState();
}

class _FlipCameraButtonState extends State<FlipCameraButton> {
  double turns = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      child: IconButton(
        color: Colors.white,
        icon: Icon(Icons.flip_camera_android_outlined),
        onPressed: () {
          setState(() => turns += 1 / 2);
          widget.onPressed?.call();
        },
      ),
      duration: Duration(milliseconds: 1000),
      turns: turns,
    );
  }
}
