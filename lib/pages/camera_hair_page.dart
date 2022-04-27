import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:healthy/pages/result_hair_page.dart';
import 'package:healthy/widgets/camera_page.dart';

class CameraHairPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CameraPage(
      foreground: DottedBorder(
        child: Container(height: 350),
        borderType: BorderType.RRect,
        dashPattern: [15, 5],
        radius: Radius.circular(30),
        color: Colors.white,
        strokeWidth: 3,
      ),
      onCapture: (image) => Get.off(() => ResultHairPage(image)),
    );
  }
}
