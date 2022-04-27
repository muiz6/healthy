import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:healthy/pages/result_skin_page.dart';
import 'package:healthy/widgets/camera_page.dart';

class CameraSkinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CameraPage(
      type: 'skin',
      foreground: DottedBorder(
        child: Container(height: 350),
        borderType: BorderType.Oval,
        dashPattern: [15, 5],
        color: Colors.white,
        strokeWidth: 3,
      ),
      onCapture: (result) => Get.off(() => ResultSkinPage(result)),
    );
  }
}
