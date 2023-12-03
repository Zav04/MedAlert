import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../Overlay/Overlay.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  final Function(String) onImageCaptured;

  CameraScreen({Key? key, required this.onImageCaptured}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with ErrorMessageOverlayMixin {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isPictureTaken = false;
  String? lastImagePath;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();
      CameraDescription rearCamera = cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );

      controller = CameraController(rearCamera, ResolutionPreset.max);
      await controller!.initialize();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print(e.toString()); // Isso vai imprimir o erro específico
      // Aqui você pode adicionar mais lógica de tratamento de erro
    }
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
      setState(() {
        isPictureTaken = true; // Altera o estado para mostrar o botão de enviar
        lastImagePath = file.path; // Armazena o caminho da imagem
      });
      widget.onImageCaptured(file.path); // Callback com o caminho da imagem
    } catch (e) {
      // Handle the error appropriately here
      showErrorMessageOverlay(e.toString(), 1);
    }
  }

  void sendPicture() {
    // Implemente a lógica para enviar a imagem
    // Exemplo: Upload da imagem para um servidor

    // Após o envio da imagem, redefina o estado para permitir tirar outra foto
    setState(() {
      isPictureTaken = false; // Reseta o estado para mostrar o botão da câmera
      lastImagePath = null; // Limpa o caminho da última imagem
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (controller != null && controller!.value.isInitialized)
            CameraPreview(controller!)
          else
            const Center(child: CircularProgressIndicator()),
          // ... outros widgets ...
        ],
      ),
      floatingActionButton: isPictureTaken
          ? FloatingActionButton(
              onPressed: sendPicture,
              child: const Icon(Icons.send),
            )
          : FloatingActionButton(
              onPressed: takePicture,
              child: const Icon(Icons.camera_alt),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
