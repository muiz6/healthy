import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/services/repository.dart' as repository;

class CameraPage extends StatefulWidget {
  final Widget? foreground;
  final void Function(File image)? onCapture;

  CameraPage({this.foreground, this.onCapture});

  @override
  State<CameraPage> createState() => _CameraHairPageState();
}

class _CameraHairPageState extends State<CameraPage> {
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
    return Stack(
      children: [
        _cameraController != null
            ? Container(
                child: AspectRatio(
                  child: CameraPreview(_cameraController!),
                  aspectRatio: _cameraAspectRatio,
                ),
                color: Colors.black,
                alignment: Alignment.center,
              )
            : Container(color: Colors.black),
        Scaffold(
          appBar: AppBar(foregroundColor: Colors.white),
          body: Column(
            children: [
              Container(
                child: Text(
                  'Message',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0x88000000),
                padding: EdgeInsets.all(16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: widget.foreground,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
          backgroundColor: Colors.transparent,
        ),
      ],
      fit: StackFit.expand,
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
      widget.onCapture?.call(File(file.path));
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
