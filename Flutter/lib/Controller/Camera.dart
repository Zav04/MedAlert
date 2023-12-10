import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../Overlay/Overlay.dart';
import 'dart:io';
import 'dart:typed_data';
import '../Controller/DataBaseConection.dart';
import '../Class/Class_MedicalPrescription.dart';

class CameraScreen extends StatefulWidget {
  final Appointment medicalAppointments;
  final Function(String) onImageCaptured;

  CameraScreen(
      {Key? key,
      required this.medicalAppointments,
      required this.onImageCaptured})
      : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with ErrorMessageOverlayMixin {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isPictureTaken = false;
  String? lastImagePath;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
      showErrorMessageOverlay(e.toString(), 1);
    }
  }

  Future<void> toggleFlash() async {
    // Alterna o estado do flash.
    isFlashOn = !isFlashOn;
    // Aplica a configuração do flash ao CameraController.
    try {
      await controller?.setFlashMode(
        isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      setState(() {});
    } catch (e) {
      // Handle the error appropriately here.
      showErrorMessageOverlay(e.toString(), 1);
    }
  }

  Future<void> disableFlash() async {
    try {
      await controller?.setFlashMode(
        FlashMode.off,
      );
      setState(() {});
    } catch (e) {
      // Handle the error appropriately here.
      showErrorMessageOverlay(e.toString(), 1);
    }
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
      widget.onImageCaptured(file.path);
      // Callback com o caminho da imagem
      disableFlash();
    } catch (e) {
      // Handle the error appropriately here
      showErrorMessageOverlay(e.toString(), 1);
    }
  }

  void sendPicture() async {
    if (lastImagePath == null) {
      return;
    }

    File imageFile = File(lastImagePath!);
    Uint8List imageBytes = await imageFile.readAsBytes();

    DateTime datetime = DateTime.now();
    String dateStr = datetime.toString();

    var result = await createHistoricMedicalPrescription(
      idMedicalPrescription: widget.medicalAppointments.idPrescricao,
      date: dateStr,
      validation: false,
      imageValidation: imageBytes,
    );

    if (result.success == true) {
      showErrorMessageOverlay('Registo Guardado', 2);
      Navigator.pop(context, true);
      // Informa que os dados foram atualizados e que é necessário atualizar o MainMenu
    } else {
      showErrorMessageOverlay(result.errorMessage.toString(), 1);
      Navigator.pop(context, false);
    }

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
          GestureDetector(
            onTapDown: (details) => onFocusTap(details),
            child: isPictureTaken && lastImagePath != null
                ? Image.file(File(lastImagePath!))
                : controller != null && controller!.value.isInitialized
                    ? CameraPreview(controller!)
                    : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
              child: isPictureTaken
                  ? Container() // Se isPictureTaken for true, não mostra o botão do flash
                  : FloatingActionButton(
                      mini: true, // Faz o botão ser menor
                      onPressed: toggleFlash,
                      child: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
                    ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: isPictureTaken
                ? FloatingActionButton(
                    onPressed: sendPicture,
                    child: const Icon(Icons.send),
                  )
                : FloatingActionButton(
                    onPressed: takePicture,
                    child: const Icon(Icons.camera_alt),
                  ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onFocusTap(TapDownDetails details) async {
    // Se a imagem já foi tirada, não faça nada
    if (isPictureTaken) {
      return;
    }

    if (!controller!.value.isInitialized) {
      return;
    }

    // Calcular a posição do ponto de foco
    final Size screenSize = MediaQuery.of(context).size;
    final double screenH = screenSize.height;
    final double screenW = screenSize.width;

    // Convertendo coordenadas de toque em valores entre 0 e 1
    final Offset focusPoint = Offset(
      details.localPosition.dx / screenW,
      details.localPosition.dy / screenH,
    );

    // Definindo o ponto de foco
    await controller!.setFocusPoint(focusPoint);
    await controller!.setFocusMode(FocusMode.auto);
  }
}
