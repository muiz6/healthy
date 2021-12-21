import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:healthy/dimens.dart' as dimens;

class CameraHairPage extends StatefulWidget {
  @override
  State<CameraHairPage> createState() => _CameraHairPageState();
}

class _CameraHairPageState extends State<CameraHairPage> {
  CameraController? _cameraController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder<CameraController?>(
            future: _initializeCamera(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return CameraPreview(snapshot.data!);
              }
              return Container(
                color: Colors.black,
              );
            },
          ),
          Column(
            children: [
              Container(),
              SvgPicture.asset(
                'assets/svg/hair_guide.svg',
                color: Colors.white,
              ),
              Column(
                children: [
                  Container(
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
                  SizedBox(
                    height: 50,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<CameraController?> _initializeCamera() async {
    final availableCameraList = await availableCameras();
    _cameraController =
        CameraController(availableCameraList[0], ResolutionPreset.max);
    await _cameraController?.initialize();
    return _cameraController;
  }
}
