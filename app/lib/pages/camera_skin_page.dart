import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/pages/result_hair_page.dart';
import 'package:healthy/pages/result_skin_page.dart';
import 'package:healthy/services/repository.dart' as repository;

class CameraSkinPage extends StatefulWidget {
  @override
  State<CameraSkinPage> createState() => _CameraSkinPageState();
}

class _CameraSkinPageState extends State<CameraSkinPage> {
  int _selectedCamera = 0;
  CameraController? _cameraController;
  double _cameraAspectRatio = 1;

  @override
  void initState() {
    _onFlipCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          _cameraController != null
              ? Container(
                  child: AspectRatio(
                    child: CameraPreview(_cameraController!),
                    aspectRatio: _cameraAspectRatio,
                  ),
                  color: Colors.black,
                  alignment: Alignment.center)
              : Container(color: Colors.black),
          Column(
            children: [
              Container(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DottedBorder(
                  child: Container(
                    height: 350,
                  ),
                  borderType: BorderType.Oval,
                  dashPattern: [15, 5],
                  color: Colors.white,
                  strokeWidth: 5,
                ),
              ),
              Padding(
                child: Stack(
                  children: [
                    Center(
                      child: GestureDetector(
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                        ),
                        onTap: _onCapture,
                      ),
                    ),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.flip_camera_android_outlined),
                          onPressed: _onFlipCamera,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(bottom: 50),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ],
        fit: StackFit.expand,
      ),
      extendBodyBehindAppBar: true,
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _onCapture() async {
    if (_cameraController != null) {
      final file = await _cameraController!.takePicture();
      final report = await repository.postReportSkin(File(file.name));
      Get.off(() => ResultSkinPage(report));
    }
  }

  Future<void> _onFlipCamera() async {
    _cameraController?.dispose();
    setState(() => _cameraController = null);
    _selectedCamera = (_selectedCamera + 1) % 2;
    final availableCameraList = await availableCameras();
    _cameraController = CameraController(
        availableCameraList[_selectedCamera], ResolutionPreset.max);
    await _cameraController?.initialize();
    _cameraAspectRatio = _cameraController?.value.aspectRatio ?? 1;
    _cameraAspectRatio = 1 / _cameraAspectRatio;
    setState(() {});
  }
}
