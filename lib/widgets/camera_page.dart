import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

import 'package:healthy/config.dart' as config;
import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/widgets/flip_camera_button.dart';

class CameraPage extends StatefulWidget {
  final Widget? foreground;
  final void Function(Map<String, dynamic> result)? onCapture;
  final String type;

  CameraPage({this.foreground, this.onCapture, required this.type});

  @override
  State<CameraPage> createState() => _CameraHairPageState();
}

class _CameraHairPageState extends State<CameraPage> {
  int _selectedCamera = 0;
  CameraController? _cameraController;
  double _cameraAspectRatio = 1;
  bool processing = false;
  Size? _camSize;

  @override
  void initState() {
    () async {
      await Future.delayed(Duration(seconds: 1));
      _onFlipCamera();
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(color: Colors.black),
        _cameraController != null
            ? UnconstrainedBox(
                child: SizedBox(
                  child: CameraPreview(_cameraController!),
                  height: deviceSize.height /
                      _cameraAspectRatio *
                      config.cameraAspectTweak,
                  width: deviceSize.width,
                ),
              )
            : SizedBox(),
        Scaffold(
          appBar: AppBar(foregroundColor: Colors.white),
          body: Column(
            children: [
              Container(
                child: Text(
                  processing ? 'Processing...' : 'Message',
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
                child: Row(
                  children: [
                    IconButton(
                      color: Colors.white,
                      disabledColor: Colors.grey,
                      icon: Icon(Icons.image_outlined),
                      onPressed: processing ? null : _onPickFile,
                    ),
                    processing
                        ? JumpingDots(
                            color: Colors.white,
                            radius: 10,
                            numberOfDots: 3,
                            animationDuration: Duration(milliseconds: 200),
                          )
                        : GestureDetector(
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
                    FlipCameraButton(onPressed: _onFlipCamera),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                padding: const EdgeInsets.only(
                  bottom: 50,
                  left: 16,
                  right: 16,
                ),
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
      setState(() => processing = true);
      final result = await _getResult(File(file.path));
      widget.onCapture?.call(result);
    }
  }

  Future<void> _onFlipCamera() async {
    _cameraController?.dispose();
    setState(() => _cameraController = null);
    _selectedCamera = (_selectedCamera + 1) % 2;
    final availableCameraList = await availableCameras();
    _cameraController = CameraController(
      availableCameraList[_selectedCamera],
      ResolutionPreset.max,
      enableAudio: false,
    );
    await _cameraController?.initialize();
    _cameraAspectRatio = _cameraController?.value.aspectRatio ?? 1;
    _cameraAspectRatio = 1 / _cameraAspectRatio;
    _camSize = _cameraController?.value.previewSize;
    setState(() {});
  }

  Future<void> _onPickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    final file = result?.files.first;
    if (file != null) {
      setState(() => processing = true);
      final result = await _getResult(File(file.path!));
      widget.onCapture?.call(result);
    }
  }

  Future<Map<String, dynamic>> _getResult(File imageFile) {
    if (widget.type == 'hair') {
      return repository.postReportHair(imageFile);
    }
    if (widget.type == 'skin') {
      return repository.postReportSkin(imageFile);
    }
    throw ArgumentError('Invalid Type');
  }
}
