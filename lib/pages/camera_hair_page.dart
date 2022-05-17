import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:healthy/pages/result_hair_page.dart';
import 'package:healthy/widgets/camera_page.dart';

class CameraHairPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CameraPage(
      type: 'hair',
      foreground: DottedBorder(
        child: Container(height: 350),
        borderType: BorderType.RRect,
        dashPattern: [15, 5],
        radius: Radius.circular(30),
        color: Colors.white,
        strokeWidth: 3,
      ),
      onCapture: (result) => Get.off(() => ResultHairPage(result)),
      message:
          'Ensure your hair must be inside the dotted area for better scan.',
    );
  }
}
