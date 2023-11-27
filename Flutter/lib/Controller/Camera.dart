import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    CameraDescription rearCamera = cameras!.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
    );

    controller = CameraController(
      rearCamera,
      ResolutionPreset.max,
    );

    await controller!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    if (!controller!.value.isInitialized || controller!.value.isTakingPicture) {
      return;
    }

    try {
      final XFile file = await controller!.takePicture();
      print('Picture saved to ${file.path}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }

    // Usando Stack para sobrepor o botão sobre a CameraPreview
    return Scaffold(
      body: Stack(
        fit: StackFit
            .expand, // Faz com que os filhos da Stack se expandam para preencher o espaço disponível
        children: [
          CameraPreview(controller!), // Removido o widget Expanded
          Positioned(
            bottom: 20.0,
            right: 20.0,
            left: 20.0,
            child: FloatingActionButton(
              onPressed: takePicture,
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }
}
